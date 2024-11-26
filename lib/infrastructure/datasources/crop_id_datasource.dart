import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hydrosync/config/config.dart';

import 'package:hydrosync/domain/datasources/crop_health_datasource.dart';
import 'package:hydrosync/domain/entities/crop_health.dart';
import 'package:hydrosync/infrastructure/models/crop_id_response.dart';


class CropIdDatasource extends CropHealthDatasource{
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://crop.kindwise.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Api-Key': Environment.cropIdKey,
        'Content-Type': 'application/json',
      },
      queryParameters: {
        'details': 'common_names,type,taxonomy,eppo_code,eppo_regulation_status,gbif_id,image,images,wiki_url,wiki_description,treatment,description,symptoms,severity,spreading',
        'language': 'en',
      },
    ),
  );

  @override
  Future<CropHealth> analyzeImage(String imagePath) async {
    try {
      final imageFile = File(imagePath);

      // Verificar si el archivo existe
      if (!await imageFile.exists()) {
        throw Exception('El archivo de imagen no existe.');
      }

      // Leer la imagen como bytes y codificar en base64
      final bytes = await imageFile.readAsBytes();
      final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';

      // Crear el cuerpo de la solicitud JSON
      final data = {
        'images': [base64Image],
        'latitude': 0,
        'longitude': 0,
        'similar_images': true,
      };

      // Realizar la solicitud POST
      final response = await dio.post(
        '/api/v1/identification',
        data: data,
      );

      // Verificar el estado de la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parsear la respuesta
        final cropIdResponse = CropIdResponse.fromJson(response.data);

        // Mapear el modelo a la entidad
        final cropHealth = _mapToEntity(cropIdResponse);

        return cropHealth;
      } else {
        throw Exception(
            'Error en la solicitud: Código de estado ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error en la solicitud: ${e.message}');
    } catch (e) {
      throw Exception('Error al analizar la imagen: $e');
    }
  }

  CropHealth _mapToEntity(CropIdResponse response) {
    // Verificar si 'result' es nulo
    if (response.result == null) {
      throw Exception('No se encontraron resultados en la respuesta.');
    }

    final result = response.result!;

    // Verificar si 'disease' no es nulo y tiene sugerencias
    if (result.disease == null ||
        result.disease!.suggestions == null ||
        result.disease!.suggestions!.isEmpty) {
      throw Exception('No se encontraron sugerencias para la imagen proporcionada.');
    }

    // Tomar la primera sugerencia de enfermedad
    final diseaseSuggestion = result.disease!.suggestions!.first;

    // Manejar posibles nulls en diseaseSuggestion.details
    if (diseaseSuggestion.details == null) {
      throw Exception('No hay detalles disponibles para la enfermedad detectada.');
    }

    final diseaseDetails = diseaseSuggestion.details!;

    // Obtener el tratamiento
    String treatment = 'No disponible.';
    if (diseaseDetails.treatment != null) {
      final treatmentDetails = diseaseDetails.treatment!;
      List<String> treatmentParts = [];

      if (treatmentDetails.prevention != null && treatmentDetails.prevention!.isNotEmpty) {
        treatmentParts.add('Prevención:\n${treatmentDetails.prevention!.join('\n')}');
      }
      if (treatmentDetails.chemicalTreatment != null &&
          treatmentDetails.chemicalTreatment!.isNotEmpty) {
        treatmentParts.add(
            'Tratamiento Químico:\n${treatmentDetails.chemicalTreatment!.join('\n')}');
      }
      if (treatmentDetails.biologicalTreatment != null &&
          treatmentDetails.biologicalTreatment!.isNotEmpty) {
        treatmentParts.add(
            'Tratamiento Biológico:\n${treatmentDetails.biologicalTreatment!.join('\n')}');
      }

      if (treatmentParts.isNotEmpty) {
        treatment = treatmentParts.join('\n\n');
      }
    }

    // Obtener la descripción de la enfermedad
    String diseaseDescription = diseaseDetails.description ?? 'No disponible.';

    // Obtener la URL de la imagen de referencia
    String diseaseImageUrl = '';
    if (diseaseSuggestion.similarImages != null &&
        diseaseSuggestion.similarImages!.isNotEmpty) {
      diseaseImageUrl = diseaseSuggestion.similarImages!.first.url ?? '';
    }

    // Construir la entidad CropHealth
    return CropHealth(
      diseaseName: diseaseSuggestion.name ?? 'Desconocido',
      diseaseProbability: diseaseSuggestion.probability ?? 0.0,
      diseaseDescription: diseaseDescription,
      treatment: treatment,
      diseaseImageUrl: diseaseImageUrl,
    );
  }

}