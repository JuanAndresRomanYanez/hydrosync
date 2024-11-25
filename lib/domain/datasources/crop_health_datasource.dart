
import 'package:hydrosync/domain/entities/entities.dart';

abstract class CropHealthDatasource {
  Future<CropHealth> analyzeImage(String imagePath);
}