import 'package:firebase_database/firebase_database.dart';
import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
import 'package:hydrosync/domain/entities/control.dart';
import 'package:hydrosync/domain/entities/crop.dart';
import 'package:hydrosync/domain/entities/details.dart';
import 'package:hydrosync/domain/entities/greenhouse.dart';
import 'package:hydrosync/domain/entities/sensor.dart';
import 'package:hydrosync/infrastructure/models/models.dart';

class GreenhouseRealtimeFirebaseDatasource extends GreenhousesDatasource {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  Stream<List<Greenhouse>> getAllGreenhouses() {
    return _databaseRef.child('greenhouses').onValue.map((event) {
      final snapshot = event.snapshot;

      if (snapshot.exists && snapshot.value != null) {
        // Intentamos convertir los datos a un Map
        final Map<dynamic, dynamic> greenhousesMap = snapshot.value as Map<dynamic, dynamic>;

        // Mapeamos los valores del Map a una lista de Greenhouse
        return greenhousesMap.values.map((value) {
          // Convertimos cada value (de tipo Map) a un Map<String, dynamic> necesario para fromJson
          final data = Map<String, dynamic>.from(value as Map);
          
          // Imprimimos el JSON para verificar su estructura
          // print(data);

          return GreenhouseModel.fromJson(data).toEntity();
        }).toList();
      } else {
        // Si el snapshot está vacío, retornamos una lista vacía
        return [];
      }
    });
  }
  
  @override
Future<void> updateGreenhouseDetails(int id, Details details) async {
  final greenhousesRef = _databaseRef.child('greenhouses');

  final snapshot = await greenhousesRef.get();

  if (snapshot.exists && snapshot.value != null) {
    final greenhousesMap = snapshot.value as Map<dynamic, dynamic>;

    String? greenhouseKey;
    for (var entry in greenhousesMap.entries) {
      final data = Map<String, dynamic>.from(entry.value['details']);
      if (data['id'] == id) {
        greenhouseKey = entry.key;
        break;
      }
    }

    if (greenhouseKey != null) {
      final reference = _databaseRef.child('greenhouses/$greenhouseKey/details');
      final updatedDetails = {
        'location': details.location,
        'name': details.name,
        'size': details.size,
        'status': details.status,
        'id': details.id,
      };

      await reference.update(updatedDetails);
    } else {
      throw Exception("Invernadero con ID $id no encontrado.");
    }
  } else {
    throw Exception("No se encontraron invernaderos en Firebase.");
  }


  
}

  @override
  Future<void> updateSensorData(int greenhouseId, String sensorId, Sensor sensor) async{
    final greenhousesRef = _databaseRef.child('greenhouses');

    final snapshot = await greenhousesRef.get();

    if (snapshot.exists && snapshot.value != null) {
      final greenhousesMap = snapshot.value as Map<dynamic, dynamic>;

      String? greenhouseKey;
      for (var entry in greenhousesMap.entries) {
        final data = Map<String, dynamic>.from(entry.value['details']);
        if (data['id'] == greenhouseId) {
          greenhouseKey = entry.key;
          break;
        }
      }

      if (greenhouseKey != null) {
        final sensorRef = _databaseRef.child('greenhouses/$greenhouseKey/sensors/$sensorId');
        final sensorModel = SensorModel.fromEntity(sensor);

        await sensorRef.update(sensorModel.toJson());
      } else {
        throw Exception("Invernadero con ID $greenhouseId no encontrado.");
      }
    } else {
      throw Exception("No se encontraron invernaderos en Firebase.");
    }
  }

  @override
  Stream<List<Crop>> getAllCrops() {
    return _databaseRef.child('crops').onValue.map((event) {
      final snapshot = event.snapshot;

      if (snapshot.exists && snapshot.value != null) {
        // Intentamos convertir los datos a un Map
        final Map<dynamic, dynamic> cropsMap = snapshot.value as Map<dynamic, dynamic>;

        // Mapeamos los valores del Map a una lista de Crop
        return cropsMap.values.map((value) {
          // Convertimos cada value (de tipo Map) a un Map<String, dynamic> necesario para fromJson
          final data = Map<String, dynamic>.from(value as Map);
          
          return CropModel.fromJson(data).toEntity();
        }).toList();
      } else {
        // Si el snapshot está vacío, retornamos una lista vacía
        return [];
      }
    });
  }
  
  @override
  Future<void> addCropToGreenhouse(int greenhouseId, Crop crop) async {
    final greenhousesRef = _databaseRef.child('greenhouses');

    final snapshot = await greenhousesRef.get();

    if (snapshot.exists && snapshot.value != null) {
      final greenhousesMap = snapshot.value as Map<dynamic, dynamic>;

      String? greenhouseKey;
      for (var entry in greenhousesMap.entries) {
        final data = Map<String, dynamic>.from(entry.value['details']);
        if (data['id'] == greenhouseId) {
          greenhouseKey = entry.key;
          break;
        }
      }

      if (greenhouseKey != null) {
        final cropsRef = _databaseRef.child('greenhouses/$greenhouseKey/crops');
        final newCropRef = cropsRef.push(); // Genera una nueva clave
        final cropModel = CropModel.fromEntity(crop);

        await newCropRef.set(cropModel.toJson());
      } else {
        throw Exception("Invernadero con ID $greenhouseId no encontrado.");
      }
    } else {
      throw Exception("No se encontraron invernaderos en Firebase.");
    }
  }
  
  @override
  Future<void> removeCropFromGreenhouse(int greenhouseId, int cropId) async{
    final greenhousesRef = _databaseRef.child('greenhouses');

    final snapshot = await greenhousesRef.get();

    if (snapshot.exists && snapshot.value != null) {
      final greenhousesMap = snapshot.value as Map<dynamic, dynamic>;

      String? greenhouseKey;
      for (var entry in greenhousesMap.entries) {
        final data = Map<String, dynamic>.from(entry.value['details']);
        if (data['id'] == greenhouseId) {
          greenhouseKey = entry.key;
          break;
        }
      }

      if (greenhouseKey != null) {
        final cropsRef = _databaseRef.child('greenhouses/$greenhouseKey/crops');

        // Obtener el snapshot de los cultivos
        final cropsSnapshot = await cropsRef.get();

        if (cropsSnapshot.exists && cropsSnapshot.value != null) {
          final cropsMap = cropsSnapshot.value as Map<dynamic, dynamic>;

          String? cropKey;
          for (var entry in cropsMap.entries) {
            final data = Map<String, dynamic>.from(entry.value);
            if (data['id'] == cropId) {
              cropKey = entry.key;
              break;
            }
          }

          if (cropKey != null) {
            // Eliminar el cultivo
            await cropsRef.child(cropKey).remove();
          } else {
            throw Exception("Cultivo con ID $cropId no encontrado en el invernadero.");
          }
        } else {
          throw Exception("No se encontraron cultivos en el invernadero.");
        }
      } else {
        throw Exception("Invernadero con ID $greenhouseId no encontrado.");
      }
    } else {
      throw Exception("No se encontraron invernaderos en Firebase.");
    }
  }

  @override
  Future<void> updateControlData(int greenhouseId, String controlId, Control control) async{
    final greenhousesRef = _databaseRef.child('greenhouses');

    final snapshot = await greenhousesRef.get();

    if (snapshot.exists && snapshot.value != null) {
      final greenhousesMap = snapshot.value as Map<dynamic, dynamic>;

      String? greenhouseKey;
      for (var entry in greenhousesMap.entries) {
        final data = Map<String, dynamic>.from(entry.value['details']);
        if (data['id'] == greenhouseId) {
          greenhouseKey = entry.key;
          break;
        }
      }

      if (greenhouseKey != null) {
        final controlsRef = _databaseRef.child('greenhouses/$greenhouseKey/controls');

        // Obtener el snapshot de los controles
        final controlsSnapshot = await controlsRef.get();

        if (controlsSnapshot.exists && controlsSnapshot.value != null) {
          final controlsMap = controlsSnapshot.value as Map<dynamic, dynamic>;

          String? controlKey;
          for (var entry in controlsMap.entries) {
            final data = Map<String, dynamic>.from(entry.value);
            if (data['id'] == controlId) {
              controlKey = entry.key;
              break;
            }
          }

          if (controlKey != null) {
            // Actualizar el control
            final controlRef = controlsRef.child(controlKey);
            final controlModel = ControlModel.fromEntity(control);

            await controlRef.update(controlModel.toJson());
          } else {
            throw Exception("Control con ID $controlId no encontrado en el invernadero.");
          }
        } else {
          throw Exception("No se encontraron controles en el invernadero.");
        }
      } else {
        throw Exception("Invernadero con ID $greenhouseId no encontrado.");
      }
    } else {
      throw Exception("No se encontraron invernaderos en Firebase.");
    }
  }
  
}
