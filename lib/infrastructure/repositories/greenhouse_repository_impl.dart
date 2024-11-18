

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
  
  @override
  Future<void> updateSensorData(int greenhouseId, String sensorId, Sensor sensor) {
    return datasource.updateSensorData(greenhouseId, sensorId, sensor);
  }
  
  @override
  Stream<List<Crop>> getAllCrops() {
    return datasource.getAllCrops();
  }
  
  @override
  Future<void> addCropToGreenhouse(int greenhouseId, Crop crop) {
    return datasource.addCropToGreenhouse(greenhouseId, crop);
  }
  
  @override
  Future<void> removeCropFromGreenhouse(int greenhouseId, int cropId) {
    return datasource.removeCropFromGreenhouse(greenhouseId, cropId);
  }
  
  @override
  Future<void> updateControlData(int greenhouseId, String controlId, Control control) {
    return datasource.updateControlData(greenhouseId, controlId, control);
  }
  

}