import 'package:firebase_database/firebase_database.dart';
import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
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
}