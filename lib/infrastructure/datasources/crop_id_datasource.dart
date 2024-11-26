import 'dart:convert';
import 'dart:io';

import 'package:translator/translator.dart';
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

  Future<CropHealth> _mapToEntity(CropIdResponse response) async {
    try {
      if (response.result == null) {
        throw Exception('No se encontraron resultados en la respuesta.');
      }

      final result = response.result!;

      if (result.disease == null) {
        throw Exception('Información incompleta en la respuesta.');
      }

      if (result.disease!.suggestions == null || result.disease!.suggestions!.isEmpty) {
        throw Exception('No se encontraron sugerencias para la imagen proporcionada.');
      }

      final diseaseSuggestion = result.disease!.suggestions!.first;

      if (diseaseSuggestion.details == null) {
        throw Exception('No hay detalles disponibles para la enfermedad detectada.');
      }

      final translator = GoogleTranslator();

      // Traducción de textos
      final diseaseName = await translator.translate(
        diseaseSuggestion.name ?? 'Desconocido',
        from: 'en',
        to: 'es',
      );
      final diseaseDescription = await translator.translate(
        diseaseSuggestion.details!.description ?? 'No disponible.',
        from: 'en',
        to: 'es',
      );

      // Obtener los tratamientos
      List<String>? prevention;
      List<String>? chemicalTreatment;
      List<String>? biologicalTreatment;

      if (diseaseSuggestion.details!.treatment != null) {
        final treatmentDetails = diseaseSuggestion.details!.treatment!;

        if (treatmentDetails.prevention != null && treatmentDetails.prevention!.isNotEmpty) {
          // Traducir la lista de prevención
          prevention = await Future.wait(
            treatmentDetails.prevention!.map((item) async {
              final translation = await translator.translate(item, from: 'en', to: 'es');
              return translation.text;
            }),
          );
        }

        if (treatmentDetails.chemicalTreatment != null && treatmentDetails.chemicalTreatment!.isNotEmpty) {
          // Traducir la lista de tratamiento químico
          chemicalTreatment = await Future.wait(
            treatmentDetails.chemicalTreatment!.map((item) async {
              final translation = await translator.translate(item, from: 'en', to: 'es');
              return translation.text;
            }),
          );
        }

        if (treatmentDetails.biologicalTreatment != null && treatmentDetails.biologicalTreatment!.isNotEmpty) {
          // Traducir la lista de tratamiento biológico
          biologicalTreatment = await Future.wait(
            treatmentDetails.biologicalTreatment!.map((item) async {
              final translation = await translator.translate(item, from: 'en', to: 'es');
              return translation.text;
            }),
          );
        }
      }

      return CropHealth(
        diseaseName: diseaseName.text,
        diseaseProbability: diseaseSuggestion.probability ?? 0.0,
        diseaseDescription: diseaseDescription.text,
        diseaseImageUrl: (diseaseSuggestion.similarImages != null &&
                diseaseSuggestion.similarImages!.isNotEmpty)
            ? diseaseSuggestion.similarImages!.first.url ?? ''
            : '',
        prevention: prevention,
        chemicalTreatment: chemicalTreatment,
        biologicalTreatment: biologicalTreatment,
      );
    } catch (e, stackTrace) {
      print('Exception in _mapToEntity: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Error al procesar la respuesta de la API: $e');
    }
  }

}