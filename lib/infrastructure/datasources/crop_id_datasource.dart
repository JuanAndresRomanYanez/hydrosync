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
  Future<CropHealth> analyzeImage(String imagePath) async{
    print('analyzeImage llamado con imagePath: $imagePath');
    try {
      // Verificar si el archivo existe
      final fileExists = await File(imagePath).exists();
      print('El archivo existe: $fileExists');

      // Leer la imagen como bytes
      print('Intentando leer el archivo de imagen...');
      final File imageFile = File(imagePath);
      final bytes = await imageFile.readAsBytes();
      print('Archivo de imagen leído correctamente, tamaño: ${bytes.length} bytes');

      final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';
      print('Imagen codificada en base64, longitud: ${base64Image.length} caracteres');

      // Crear el cuerpo de la solicitud JSON
      final data = {
        'images': [base64Image],
        'latitude': 0,
        'longitude': 0,
        'similar_images': true,
      };

      print('Realizando la solicitud POST...');
      final response = await dio.post(
        '/api/v1/identification',
        data: data,
      );

      print('Solicitud POST realizada, esperando respuesta...');

      // Verificar el estado de la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Respuesta exitosa recibida');
        // print('Datos de respuesta JSON completo: ${jsonEncode(response)}');
        print('Datos de respuesta: ${response.data}');
        // Parsear la respuesta
        final cropIdResponse = CropIdResponse.fromJson(response.data);
        print('LLega a parsearse correctamente');
        // Mapear el modelo a la entidad
        final cropHealth = _mapToEntity(cropIdResponse);
        print('Accede aqui 1 token menos aghhhh');

        return cropHealth;
      } else {
        print('Error en la solicitud: Código de estado ${response.statusCode}');
        print('Detalles del error: ${response.data}');
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException atrapada: ${e.message}');
      print('Detalles del error: ${e.response?.data}');
      throw Exception('Error en la solicitud: ${e.message}');
    } catch (e) {
      print('Excepción atrapada en analyzeImage: $e');
      throw Exception('Error al analizar la imagen: $e');
    }
  }

  CropHealth _mapToEntity(CropIdResponse response) {
    try {
      // Verificar si 'result' es nulo
      if (response.result == null) {
        throw Exception('No se encontraron resultados en la respuesta.');
      }

      final result = response.result!;

      // Verificar si 'disease' y 'crop' no son nulos
      if (result.disease == null ) {
        throw Exception('Información incompleta en la respuesta.');
      }

      // Verificar si hay sugerencias disponibles
      if (result.disease!.suggestions == null || result.disease!.suggestions!.isEmpty) {
        throw Exception('No se encontraron sugerencias para la imagen proporcionada.');
      }

      // Tomar la primera sugerencia de enfermedad y cultivo
      final diseaseSuggestion = result.disease!.suggestions!.first;

      // Manejar posibles nulls en diseaseSuggestion
      if (diseaseSuggestion == null) {
        throw Exception('No hay sugerencias de enfermedad disponibles.');
      }

      // Manejar posibles nulls en diseaseSuggestion.details
      if (diseaseSuggestion.details == null) {
        throw Exception('No hay detalles disponibles para la enfermedad detectada.');
      }

      // Obtener el tratamiento
      String treatment = 'No disponible.';
      if (diseaseSuggestion.details!.treatment != null) {
        final treatmentDetails = diseaseSuggestion.details!.treatment!;
        treatment = '';

        if (treatmentDetails.prevention != null && treatmentDetails.prevention.isNotEmpty) {
          treatment += 'Prevención:\n${treatmentDetails.prevention.join('\n')}\n\n';
        }
        if (treatmentDetails.chemicalTreatment != null && treatmentDetails.chemicalTreatment.isNotEmpty) {
          treatment += 'Tratamiento Químico:\n${treatmentDetails.chemicalTreatment.join('\n')}\n\n';
        }
        if (treatmentDetails.biologicalTreatment != null && treatmentDetails.biologicalTreatment.isNotEmpty) {
          treatment += 'Tratamiento Biológico:\n${treatmentDetails.biologicalTreatment.join('\n')}';
        }
      }

      // Manejar posibles nulls en diseaseDescription
      String diseaseDescription = diseaseSuggestion.details!.description ?? 'No disponible.';

      // Construir la entidad CropHealth
      return CropHealth(
        diseaseName: diseaseSuggestion.name ?? 'Desconocido',
        diseaseProbability: diseaseSuggestion.probability ?? 0.0,
        diseaseDescription: diseaseDescription,
        treatment: treatment,
        diseaseImageUrl: (diseaseSuggestion.similarImages != null && diseaseSuggestion.similarImages!.isNotEmpty)
            ? diseaseSuggestion.similarImages!.first.url ?? ''
            : '',
      );
    } catch (e, stackTrace) {
      print('Exception in _mapToEntity: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Error al procesar la respuesta de la API: $e');
    }
  }

}