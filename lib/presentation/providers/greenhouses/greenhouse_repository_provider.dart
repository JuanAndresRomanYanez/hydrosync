import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hydrosync/domain/entities/entities.dart';

import 'package:hydrosync/infrastructure/repositories/greenhouse_repository_impl.dart';
import 'package:hydrosync/infrastructure/datasources/greenhouse_realtime_firebase_datasource.dart';

import 'package:hydrosync/domain/repositories/greenhouses_repository.dart';


// Provider para el repositorio de invernaderos
final greenhouseRepositoryProvider = Provider<GreenhousesRepository>((ref) {
  return GreenhouseRepositoryImpl(
    datasource: GreenhouseRealtimeFirebaseDatasource(),
  );
});

// StreamProvider para el flujo de invernaderos en tiempo real
final greenhousesStreamProvider = StreamProvider<List<Greenhouse>>((ref) {
  final repository = ref.watch(greenhouseRepositoryProvider);
  return repository.getAllGreenhouses();
});

