import 'package:hydrosync/domain/entities/entities.dart';

class SensorModel {
  final String name;
  final String image;
  final int maxValue;
  final int minValue;
  final int updateFrequency;
  final int value;

  SensorModel({
    required this.name,
    required this.image,
    required this.maxValue,
    required this.minValue,
    required this.updateFrequency,
    required this.value,
  });

  Sensor toEntity() {
    return Sensor(
      name: name,
      image: image,
      maxValue: maxValue,
      minValue: minValue,
      updateFrequency: updateFrequency,
      value: value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'maxValue': maxValue,
      'minValue': minValue,
      'updateFrequency': updateFrequency,
      'value': value,
    };
  }

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      maxValue: json['maxValue'] ?? 0,
      minValue: json['minValue'] ?? 0,
      updateFrequency: json['updateFrequency'] ?? 0,
      value: json['value'] ?? 0,
    );
  }
}
