import 'package:firebase_database/firebase_database.dart';
import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
import 'package:hydrosync/domain/entities/details.dart';
import 'package:hydrosync/domain/entities/greenhouse.dart';
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

  
  
  
}
