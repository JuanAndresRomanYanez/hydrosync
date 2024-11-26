import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';


import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/presentation/providers/crop_health/crop_health_provider.dart';

class CropHealthView extends ConsumerWidget {
  const CropHealthView({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cropHealthState = ref.watch(cropHealthProvider);
    final cropHealthNotifier = ref.read(cropHealthProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salud del Cultivo',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mostrar imagen seleccionada o placeholder
            GestureDetector(
              onTap: () => _showImageSourceActionSheet(context, cropHealthNotifier),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: cropHealthState.selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          cropHealthState.selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Toque para seleccionar una imagen',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            // Botón para analizar la imagen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cropHealthState.isLoading
                    ? null
                    : () => cropHealthNotifier.analyzeImage(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: cropHealthState.isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                      'Analizar Imagen',
                      style: TextStyle(color: Colors.white),
                    ),
              ),
            ),
            const SizedBox(height: 24),
            // Mostrar resultados o mensaje de error
            if (cropHealthState.errorMessage != null)
              Text(
                cropHealthState.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (cropHealthState.analysisResult != null)
              _buildAnalysisResult(cropHealthState.analysisResult!),
          ],
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context, CropHealthNotifier notifier) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar Foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera, notifier);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de la Galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, notifier);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, CropHealthNotifier notifier) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1024,
    );
    if (pickedFile != null) {
      notifier.selectImage(File(pickedFile.path));
    }
  }

  Widget _buildAnalysisResult(CropHealth result) {
    return AnalysisResultPanel(result: result);
  }
}


class AnalysisResultPanel extends StatefulWidget {
  final CropHealth result;

  const AnalysisResultPanel({
    super.key,
    required this.result,
  });

  @override
  AnalysisResultPanelState createState() => AnalysisResultPanelState();
}

class AnalysisResultPanelState extends State<AnalysisResultPanel> {
  late List<ExpandableSection> sections;

  @override
  void initState() {
    super.initState();
    sections = [
      ExpandableSection(
        title: 'Descripción',
        content: widget.result.diseaseDescription,
      ),
      if (widget.result.prevention != null && widget.result.prevention!.isNotEmpty)
        ExpandableSection(
          title: 'Prevención',
          content: widget.result.prevention!.join('\n'),
        ),
      if (widget.result.chemicalTreatment != null && widget.result.chemicalTreatment!.isNotEmpty)
        ExpandableSection(
          title: 'Tratamiento Químico',
          content: widget.result.chemicalTreatment!.join('\n'),
        ),
      if (widget.result.biologicalTreatment != null && widget.result.biologicalTreatment!.isNotEmpty)
        ExpandableSection(
          title: 'Tratamiento Biológico',
          content: widget.result.biologicalTreatment!.join('\n'),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botones para descargar y compartir PDF
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _downloadPdf,
              icon: const Icon(
                Icons.download, 
                size: 24, 
                color: Colors.white,
              ),
              label: const Text(
                'Descargar PDF',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: _sharePdf,
              icon: const Icon(
                Icons.share, 
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                'Compartir PDF',
                style:TextStyle(color: Colors.white)
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Tarjeta con la información
        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nombre de la enfermedad
        Text(
          'Problema de salud: ${widget.result.diseaseName}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Probabilidad
        Text(
          'Probabilidad: ${(widget.result.diseaseProbability * 100).toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        // Imagen de referencia
        if (widget.result.diseaseImageUrl.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(widget.result.diseaseImageUrl),
          ),
        const SizedBox(height: 16),
        // Secciones plegables
        ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            setState(() {
              sections[index].isExpanded = !sections[index].isExpanded;
            });
          },
          children: sections.map((section) {
            return ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    section.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(section.content),
              ),
              isExpanded: section.isExpanded,
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _downloadPdf() async {
    final pdfBytes = await _generatePdfBytes();
    // Guardar el PDF en el dispositivo
    await _savePdfLocally(pdfBytes);
  }

  Future<void> _sharePdf() async {
    final pdfBytes = await _generatePdfBytes();
    // Compartir el PDF
    String fileName = '${widget.result.diseaseName}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    await Printing.sharePdf(bytes: pdfBytes, filename: fileName);
  }

  Future<Uint8List> _generatePdfBytes() async {
    final pdf = pw.Document();

    final image = widget.result.diseaseImageUrl.isNotEmpty
        ? await networkImage(widget.result.diseaseImageUrl)
        : null;

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Reporte de Salud del Cultivo',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Problema de salud: ${widget.result.diseaseName}',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Probabilidad: ${(widget.result.diseaseProbability * 100).toStringAsFixed(2)}%',
              style: const pw.TextStyle(fontSize: 16),
            ),
            pw.SizedBox(height: 10),
            if (image != null)
              pw.Center(
                child: pw.Image(image, height: 200),
              ),
            pw.SizedBox(height: 10),
            _buildPdfSection('Descripción', widget.result.diseaseDescription),
            if (widget.result.prevention != null && widget.result.prevention!.isNotEmpty)
              _buildPdfSection('Prevención', widget.result.prevention!.join('\n\n')),
            if (widget.result.chemicalTreatment != null && widget.result.chemicalTreatment!.isNotEmpty)
              _buildPdfSection('Tratamiento Químico', widget.result.chemicalTreatment!.join('\n\n')),
            if (widget.result.biologicalTreatment != null && widget.result.biologicalTreatment!.isNotEmpty)
              _buildPdfSection('Tratamiento Biológico', widget.result.biologicalTreatment!.join('\n\n')),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildPdfSection(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5),
        pw.Text(content, style: const pw.TextStyle(fontSize: 14)),
        pw.SizedBox(height: 10),
      ],
    );
  }

  Future<void> _savePdfLocally(Uint8List pdfBytes) async {
    try {
      String fileName = '${widget.result.diseaseName}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final params = SaveFileDialogParams(
        data: pdfBytes,
        fileName: fileName,
      );

      final filePath = await FlutterFileDialog.saveFile(params: params);

      if (filePath != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PDF guardado con éxito'))
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Guardado cancelado')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el PDF: $e')),
        );
      }
    }
  }




}

class ExpandableSection {
  String title;
  String content;
  bool isExpanded;

  ExpandableSection({
    required this.title,
    required this.content,
    this.isExpanded = false,
  });
}
