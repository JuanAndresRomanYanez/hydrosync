

import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
import 'package:hydrosync/domain/repositories/greenhouses_repository.dart';

import '../../domain/entities/entities.dart';

class GreenhouseRepositoryImpl extends GreenhousesRepository{

  final GreenhousesDatasource datasource;

  GreenhouseRepositoryImpl({
    required this.datasource
  });

  @override
  Stream<List<Greenhouse>> getAllGreenhouses() {
    return datasource.getAllGreenhouses();
  }
  
  @override
  Future<void> updateGreenhouseDetails(int id, Details details) {
    return datasource.updateGreenhouseDetails(id, details);
  }
  

}