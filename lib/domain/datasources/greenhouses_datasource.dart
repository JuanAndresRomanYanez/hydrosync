import '../entities/entities.dart';

abstract class GreenhousesDatasource {
  Future<List<Greenhouse>> getAllGreenhouses();
}