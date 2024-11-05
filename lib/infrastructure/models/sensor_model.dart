import 'package:hydrosync/domain/entities/entities.dart';

class SensorModel {
  final String id;
  final String name;
  final String image;
  final double maxValue;
  final double minValue;
  final double updateFrequency;
  final double value;

  SensorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.maxValue,
    required this.minValue,
    required this.updateFrequency,
    required this.value,
  });

  Sensor toEntity() {
    return Sensor(
      id: id,
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
      'id': id,
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
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      maxValue: (json['maxValue']).toDouble() ?? 0,
      minValue: (json['minValue']).toDouble() ?? 0,
      updateFrequency: (json['updateFrequency']).toDouble() ?? 0,
      value: (json['value']).toDouble() ?? 0,
    );
  }

  // Método para crear un SensorModel desde una entidad Sensor
  factory SensorModel.fromEntity(Sensor sensor) {
    return SensorModel(
      id: sensor.id,
      name: sensor.name,
      image: sensor.image,
      maxValue: sensor.maxValue,
      minValue: sensor.minValue,
      updateFrequency: sensor.updateFrequency,
      value: sensor.value,
    );
  }

}
