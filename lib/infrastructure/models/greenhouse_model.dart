import 'models.dart';
import 'package:hydrosync/domain/entities/entities.dart';

class GreenhouseModel {
  final List<CropModel> crops;
  final DetailsModel details;
  final List<SensorModel> sensors;
  final List<ControlModel> controls;

  GreenhouseModel({
    required this.crops,
    required this.details,
    required this.sensors,
    required this.controls,
  });

  factory GreenhouseModel.fromJson(Map<String, dynamic> json) {
    return GreenhouseModel(
      crops: (json['crops'] as List)
          .map((crop) => CropModel.fromJson(crop))
          .toList(),
      details: DetailsModel.fromJson(json['details']),
      sensors: (json['sensors'] as List)
          .map((sensor) => SensorModel.fromJson(sensor))
          .toList(),
      controls: (json['controls'] as List)
          .map((control) => ControlModel.fromJson(control))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'crops': crops.map((crop) => crop.toJson()).toList(),
      'details': details.toJson(),
      'sensors': sensors.map((sensor) => sensor.toJson()).toList(),
      'controls': controls.map((control) => control.toJson()).toList(),
    };
  }

  Greenhouse toEntity() {
    return Greenhouse(
      crops: crops.map((crop) => crop.toEntity()).toList(),
      details: details.toEntity(),
      sensors: sensors.map((sensor) => sensor.toEntity()).toList(),
      controls: controls.map((control) => control.toEntity()).toList(),
    );
  }
}