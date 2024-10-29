

import 'package:hydrosync/domain/datasources/greenhouses_datasource.dart';
import 'package:hydrosync/domain/repositories/greenhouses_repository.dart';

import '../../domain/entities/entities.dart';

class GreenhouseRepositoryImpl extends GreenhousesRepository{

  final GreenhousesDatasource datasource;

  GreenhouseRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Greenhouse>> getAllGreenhouses() {
    return datasource.getAllGreenhouses();
  }

}