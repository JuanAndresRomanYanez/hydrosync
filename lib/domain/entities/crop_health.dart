class CropHealth {
  final String diseaseName;
  final double diseaseProbability;
  final String diseaseDescription;
  final String diseaseImageUrl;
  final List<String>? prevention;
  final List<String>? chemicalTreatment;
  final List<String>? biologicalTreatment;

  CropHealth({
    required this.diseaseName,
    required this.diseaseProbability,
    required this.diseaseDescription,
    required this.diseaseImageUrl,
    this.prevention,
    this.chemicalTreatment,
    this.biologicalTreatment,
  });
}
