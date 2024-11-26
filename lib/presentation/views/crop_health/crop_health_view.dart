import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator/translator.dart';
import 'package:image_picker/image_picker.dart';

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
          style: TextStyle(fontSize: 24),
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
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: cropHealthState.isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Analizar Imagen'),
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
    return FutureBuilder<Map<String, String>>(
      future: _translateResult(result),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error al traducir: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final translatedData = snapshot.data!;
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre de la enfermedad
                  Text(
                    'Enfermedad: ${translatedData['diseaseName']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Probabilidad
                  Text(
                    'Probabilidad: ${(result.diseaseProbability * 100).toStringAsFixed(2)}%',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Imagen de referencia
                  if (result.diseaseImageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(result.diseaseImageUrl),
                    ),
                  const SizedBox(height: 16),
                  // Descripción
                  const Text(
                    'Descripción:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    translatedData['diseaseDescription'] ?? 'No disponible.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Tratamiento
                  const Text(
                    'Tratamiento:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    translatedData['treatment'] ?? 'No disponible.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('No se pudo obtener el resultado.');
        }
      },
    );
  }

  Future<Map<String, String>> _translateResult(CropHealth result) async {
    final translator = GoogleTranslator();

    try {
      // Traducir los textos
      final diseaseNameTranslation = await translator.translate(result.diseaseName, from: 'en', to: 'es');
      final diseaseDescriptionTranslation = await translator.translate(result.diseaseDescription, from: 'en', to: 'es');
      final treatmentTranslation = await translator.translate(result.treatment, from: 'en', to: 'es');

      return {
        'diseaseName': diseaseNameTranslation.text,
        'diseaseDescription': diseaseDescriptionTranslation.text,
        'treatment': treatmentTranslation.text,
      };
    } catch (e) {
      print('Error al traducir: $e');
      // Si hay un error, devolvemos los textos originales
      return {
        'diseaseName': result.diseaseName,
        'diseaseDescription': result.diseaseDescription,
        'treatment': result.treatment,
      };
    }
  }
}
