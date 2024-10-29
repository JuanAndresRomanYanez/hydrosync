import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/presentation/providers/greenhouses/greenhouse_repository_provider.dart';

final greenhousesProvider = FutureProvider<List<Greenhouse>>((ref) async {
  final repository = ref.watch(greenhouseRepositoryProvider);
  return await repository.getAllGreenhouses();
});