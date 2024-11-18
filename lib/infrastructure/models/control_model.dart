import 'package:hydrosync/domain/entities/entities.dart';

class ControlModel {
  final String id;
  final String name;
  final String image;
  final String mode;
  final bool status;
  final int onTime;
  final int offTime;


  ControlModel({
    required this.id,
    required this.name,
    required this.image,
    required this.mode,
    required this.status,
    required this.onTime, 
    required this.offTime,
  });

  // Método para convertir ControlModel a entidad Control
  Control toEntity() {
    return Control(
      id: id,
      name: name,
      image: image,
      mode: mode,
      status: status,
      onTime: onTime,
      offTime: offTime,
    );
  }

  // Método para convertir ControlModel a un Map para Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'mode': mode,
      'status': status,
      'onTime': onTime,
      'offTime': offTime,
    };
  }

  factory ControlModel.fromJson(Map<String, dynamic> json) {
    return ControlModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      mode: json['mode'] ?? 'manual',
      status: json['status'] ?? false,
      onTime: (json['onTime']).toInt() ?? 0,
      offTime: (json['offTime']).toInt() ?? 0,
    );
  }

  // Método para crear un ControlModel desde una entidad Control
  factory ControlModel.fromEntity(Control control) {
    return ControlModel(
      id: control.id,
      name: control.name,
      image: control.image,
      mode: control.mode,
      status: control.status,
      onTime: control.onTime,
      offTime: control.offTime,
    );
  }
}
