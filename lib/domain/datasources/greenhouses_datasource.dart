import '../entities/entities.dart';

abstract class GreenhousesDatasource {
  Stream<List<Greenhouse>> getAllGreenhouses();

  Future<void> updateGreenhouseDetails(int id, Details details);
  
  Future<void> updateSensorData(int greenhouseId, String sensorId, Sensor sensor);

  Stream<List<Crop>> getAllCrops();

  Future<void> addCropToGreenhouse(int greenhouseId, Crop crop);
  
}