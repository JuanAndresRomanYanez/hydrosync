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
      // Convierte el mapa 'crops' en una lista de CropModel
      crops: (json['crops'] as Map<dynamic, dynamic>).values
          .map((crop) => CropModel.fromJson(Map<String, dynamic>.from(crop)))
          .toList(),
      details: DetailsModel.fromJson(Map<String, dynamic>.from(json['details'])),
      
      // Convierte el mapa 'sensors' en una lista de SensorModel
      sensors: (json['sensors'] as Map<dynamic, dynamic>).values
          .map((sensor) => SensorModel.fromJson(Map<String, dynamic>.from(sensor)))
          .toList(),
      
      // Convierte el mapa 'controls' en una lista de ControlModel
      controls: (json['controls'] as Map<dynamic, dynamic>).values
          .map((control) => ControlModel.fromJson(Map<String, dynamic>.from(control)))
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