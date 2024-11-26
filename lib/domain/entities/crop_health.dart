// domain/entities/crop_health.dart

class CropHealth {
  final String diseaseName;
  final double diseaseProbability;
  final String diseaseDescription;
  final String treatment;
  final String diseaseImageUrl;

  CropHealth({
    required this.diseaseName,
    required this.diseaseProbability,
    required this.diseaseDescription,
    required this.treatment,
    required this.diseaseImageUrl,
  });
}
