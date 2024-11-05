import 'package:hydrosync/domain/entities/entities.dart';

class DetailsModel {
  final String location;
  final String name;
  final String size;
  final String status;
  final int id;

  DetailsModel({
    required this.location,
    required this.name,
    required this.size,
    required this.status,
    required this.id,
  });

  Details toEntity() {
    return Details(
      location: location,
      name: name,
      size: size,
      status: status,
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'name': name,
      'size': size,
      'status': status,
      'id': id, 
    };
  }

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      location: json['location'] ?? '',
      name: json['name'] ?? '',
      size: json['size'] ?? '',
      status: json['status'] ?? '',
      id: (json['id']).toInt() ?? 0,
    );
  }

  // Método para crear un DetailsModel desde una entidad Details
  factory DetailsModel.fromEntity(Details details) {
    return DetailsModel(
      location: details.location,
      name: details.name,
      size: details.size,
      status: details.status,
      id: details.id,
    );
  }
  
}
