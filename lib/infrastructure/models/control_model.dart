import 'package:hydrosync/domain/entities/entities.dart';

class ControlModel {
  final int time;
  final String method;
  final bool status;

  ControlModel({
    required this.time,
    required this.method,
    required this.status,
  });

  // Método para convertir ControlModel a entidad Control
  Control toEntity() {
    return Control(
      time: time,
      method: method,
      status: status,
    );
  }

  // Método para convertir ControlModel a un Map para Firebase
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'method': method,
      'status': status,
    };
  }

  factory ControlModel.fromJson(Map<String, dynamic> json) {
    return ControlModel(
      time: json['time'] ?? '',
      method: json['method'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
