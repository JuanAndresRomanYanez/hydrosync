

import 'package:hydrosync/domain/datasources/crop_health_datasource.dart';
import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/domain/repositories/crop_health_repository.dart';

class CropHealthRepositoryImpl extends CropHealthRepository{

  final CropHealthDatasource datasource;
  
  CropHealthRepositoryImpl(
    this.datasource,
  );

  @override
  Future<CropHealth> analyzeImage(String imagePath) {
    return datasource.analyzeImage(imagePath);
  }

}