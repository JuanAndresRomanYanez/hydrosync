import 'package:hydrosync/domain/entities/entities.dart';

class DetailsModel {
  final String location;
  final String name;
  final String size;
  final String status;

  DetailsModel({
    required this.location,
    required this.name,
    required this.size,
    required this.status,
  });

  Details toEntity() {
    return Details(
      location: location,
      name: name,
      size: size,
      status: status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'name': name,
      'size': size,
      'status': status,
    };
  }

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      location: json['location'] ?? '',
      name: json['name'] ?? '',
      size: json['size'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
