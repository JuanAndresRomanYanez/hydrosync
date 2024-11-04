import 'package:firebase_database/firebase_database.dart';
import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
import 'package:hydrosync/domain/entities/greenhouse.dart';
import 'package:hydrosync/infrastructure/models/models.dart';

class GreenhouseRealtimeFirebaseDatasource extends GreenhousesDatasource{
  
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  Stream<List<Greenhouse>> getAllGreenhouses() {
    // Acá mapeo cada nodo de greenhouses y lo convierto a una List<Greenhouse>
    return _databaseRef.child('greenhouses').onValue.map((event) {
      final snapshot = event.snapshot;
      
      if (snapshot.exists) {
        final Map<String, dynamic> greenhousesMap = Map<String, dynamic>.from(snapshot.value as Map);
        return greenhousesMap.values.map((value) {
          final data = Map<String, dynamic>.from(value as Map);
          return GreenhouseModel.fromJson(data).toEntity();
        }).toList();
      } else {
        return [];
      }
    });
  }

}