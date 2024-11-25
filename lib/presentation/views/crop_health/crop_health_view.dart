import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/presentation/providers/crop_health/crop_health_provider.dart';
import 'package:image_picker/image_picker.dart';

class CropHealthView extends ConsumerWidget {
  const CropHealthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cropHealthState = ref.watch(cropHealthProvider);
    final cropHealthNotifier = ref.read(cropHealthProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salud del Cultivo',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
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
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: cropHealthState.selectedImage != null
                    ? Image.file(
                        cropHealthState.selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 100,
                        color: Colors.grey,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            // Botón para analizar la imagen
            ElevatedButton(
              onPressed: cropHealthState.isLoading
                  ? null
                  : () => cropHealthNotifier.analyzeImage(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: cropHealthState.isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Analizar Imagen'),
            ),

            const SizedBox(height: 16),
            // Mostrar resultados o mensaje de error
            if (cropHealthState.errorMessage != null)
              Text(
                cropHealthState.errorMessage!,
                style: const TextStyle(color: Colors.red),
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
      imageQuality: 50,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      notifier.selectImage(File(pickedFile.path));
    }
  }

  Widget _buildAnalysisResult(CropHealth result) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cultivo: ${result.cropName}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            Text('Enfermedad: ${result.diseaseName}',
                style: const TextStyle(fontSize: 18)),
            Text(
                'Probabilidad: ${(result.diseaseProbability * 100).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(result.diseaseDescription),
            const SizedBox(height: 8),
            const Text('Tratamiento:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(result.treatment),
            const SizedBox(height: 8),
            if (result.diseaseImageUrl.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Imagen de referencia:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Image.network(result.diseaseImageUrl),
                ],
              ),
          ],
        ),
      ),
    );
  }


}
