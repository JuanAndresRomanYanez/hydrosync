import '../entities/entities.dart';

abstract class GreenhousesRepository {
  Stream<List<Greenhouse>> getAllGreenhouses();

  Future<void> updateGreenhouseDetails(int id, Details details);
  
  Future<void> updateSensorData(int greenhouseId, String sensorId, Sensor sensor);

  Stream<List<Crop>> getAllCrops();

  Future<void> addCropToGreenhouse(int greenhouseId, Crop crop);

  Future<void> removeCropFromGreenhouse(int greenhouseId, int cropId);

  Future<void> updateControlData(int greenhouseId, String controlId, Control control);
}