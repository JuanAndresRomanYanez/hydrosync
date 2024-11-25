
import 'package:hydrosync/domain/entities/entities.dart';

abstract class CropHealthRepository {
  Future<CropHealth> analyzeImage(String imagePath);
}