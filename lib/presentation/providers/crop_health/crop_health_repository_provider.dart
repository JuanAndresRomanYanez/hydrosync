
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/repositories/crop_health_repository.dart';
import 'package:hydrosync/infrastructure/datasources/crop_id_datasource.dart';
import 'package:hydrosync/infrastructure/repositories/crop_health_repository_impl.dart';

final cropHealthRepositoryProvider = Provider<CropHealthRepository>((ref) {
  final datasource = CropIdDatasource();
  return CropHealthRepositoryImpl(datasource);
});