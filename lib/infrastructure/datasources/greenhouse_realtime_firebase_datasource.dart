import 'package:firebase_database/firebase_database.dart';
import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
import 'package:hydrosync/domain/entities/greenhouse.dart';
import 'package:hydrosync/infrastructure/models/models.dart';

class GreenhouseRealtimeFirebaseDatasource extends GreenhousesDatasource{
  
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  Future<List<Greenhouse>> getAllGreenhouses() async{
    final snapshot = await _databaseRef.child('greenhouses').get();

    if (snapshot.exists) {
      final Map<String, dynamic> greenhousesMap = Map<String, dynamic>.from(snapshot.value as Map);
      final List<Greenhouse> greenhouses = greenhousesMap.values.map((value) {
        final data = Map<String, dynamic>.from(value as Map);
        return GreenhouseModel.fromJson(data).toEntity();
      }).toList();

      return greenhouses;
    } else {
      return [];
    }

  }

}