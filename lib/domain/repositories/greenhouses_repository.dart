import '../entities/entities.dart';

abstract class GreenhousesRepository {
  Stream<List<Greenhouse>> getAllGreenhouses();

  Future<void> updateGreenhouseDetails(int id, Details details);
  
  Future<void> updateSensorData(int greenhouseId, String sensorId, Sensor sensor);
}