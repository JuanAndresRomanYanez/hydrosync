import '../entities/entities.dart';

abstract class GreenhousesDatasource {
  Stream<List<Greenhouse>> getAllGreenhouses();
}