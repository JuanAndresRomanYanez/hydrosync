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

  factory GreenhouseModel.fromEntity(Greenhouse greenhouse) {
    return GreenhouseModel(
      crops: greenhouse.crops.map((crop) => CropModel.fromEntity(crop)).toList(),
      details: DetailsModel.fromEntity(greenhouse.details),
      sensors: greenhouse.sensors.map((sensor) => SensorModel.fromEntity(sensor)).toList(),
      controls: greenhouse.controls.map((control) => ControlModel.fromEntity(control)).toList(),
    );
  }

  factory GreenhouseModel.fromJson(Map<String, dynamic> json) {
    // Manejar el campo 'crops'
    List<CropModel> cropsList = [];
    if (json.containsKey('crops') && json['crops'] != null) {
      if (json['crops'] is Map) {
        cropsList = (json['crops'] as Map<dynamic, dynamic>).values
            .map((crop) => CropModel.fromJson(Map<String, dynamic>.from(crop)))
            .toList();
      } else {
        // Manejar el caso en que 'crops' no es un Map
        // print("Advertencia: 'crops' no es un Map. Valor actual: ${json['crops']}");
      }
    } else {
      // Si 'crops' no existe o es null, dejamos la lista vacía
      cropsList = [];
    }

    // Hacemos lo mismo para 'sensors' y 'controls'

    // Manejar el campo 'sensors'
    List<SensorModel> sensorsList = [];
    if (json.containsKey('sensors') && json['sensors'] != null) {
      if (json['sensors'] is Map) {
        sensorsList = (json['sensors'] as Map<dynamic, dynamic>).values
            .map((sensor) => SensorModel.fromJson(Map<String, dynamic>.from(sensor)))
            .toList();
      } else {
        // print("Advertencia: 'sensors' no es un Map. Valor actual: ${json['sensors']}");
      }
    } else {
      sensorsList = [];
    }

    // Manejar el campo 'controls'
    List<ControlModel> controlsList = [];
    if (json.containsKey('controls') && json['controls'] != null) {
      if (json['controls'] is Map) {
        controlsList = (json['controls'] as Map<dynamic, dynamic>).values
            .map((control) => ControlModel.fromJson(Map<String, dynamic>.from(control)))
            .toList();
      } else {
        // print("Advertencia: 'controls' no es un Map. Valor actual: ${json['controls']}");
      }
    } else {
      controlsList = [];
    }

    // Ahora podemos construir el GreenhouseModel
    return GreenhouseModel(
      crops: cropsList,
      details: DetailsModel.fromJson(Map<String, dynamic>.from(json['details'])),
      sensors: sensorsList,
      controls: controlsList,
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