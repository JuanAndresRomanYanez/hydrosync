import '../entities/entities.dart';

abstract class GreenhousesRepository {
  Future<List<Greenhouse>> getAllGreenhouses();
}