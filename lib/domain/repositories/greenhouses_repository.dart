import '../entities/entities.dart';

abstract class GreenhousesRepository {
  Stream<List<Greenhouse>> getAllGreenhouses();
}