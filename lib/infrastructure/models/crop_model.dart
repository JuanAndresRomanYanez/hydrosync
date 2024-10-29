import 'package:hydrosync/domain/entities/entities.dart';

class CropModel {
  final String name;
  final String description;
  final String image;

  CropModel({
    required this.name,
    required this.description,
    required this.image,
  });

  Crop toEntity() {
    return Crop(
      name: name,
      description: description,
      image: image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}