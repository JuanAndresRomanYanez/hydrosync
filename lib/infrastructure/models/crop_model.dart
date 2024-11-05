import 'package:hydrosync/domain/entities/entities.dart';

class CropModel {
  final int id;
  final String name;
  final String description;
  final String image;

  CropModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  Crop toEntity() {
    return Crop(
      id: id,
      name: name,
      description: description,
      image: image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      id: (json['id']).toInt() ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Método para crear un CropModel desde una entidad Crop
  factory CropModel.fromEntity(Crop crop) {
    return CropModel(
      id: crop.id,
      name: crop.name,
      description: crop.description,
      image: crop.image,
    );
  }
}