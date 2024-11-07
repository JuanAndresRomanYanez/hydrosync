import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/presentation/providers/providers.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class CropsAddView extends ConsumerWidget {
  final int id;

  const CropsAddView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCropsAsyncValue = ref.watch(cropsStreamProvider);
    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir Cultivo',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: allCropsAsyncValue.when(
        data: (allCrops) {
          return greenhousesAsyncValue.when(
            data: (greenhouses) {
              // Obtener el invernadero actual
              final greenhouse = greenhouses.firstWhere(
                (g) => g.details.id == id,
              );

              // Lista de cultivos ya agregados al invernadero
              final existingCrops = greenhouse.crops;

              // Filtrar los cultivos que aún no están en el invernadero
              final cropsToAdd = allCrops.where((crop) {
                return !existingCrops.any((existingCrop) => existingCrop.id == crop.id);
              }).toList();

              if (cropsToAdd.isEmpty) {
                return const Center(
                  child: Text('No hay cultivos disponibles para agregar.'),
                );
              }

              // Mostrar la lista de cultivos para agregar
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: cropsToAdd.length,
                itemBuilder: (context, index) {
                  final crop = cropsToAdd[index];
                  return CropAddCard(
                    crop: crop,
                    onAddPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context); // Capturamos antes del await
                      try {
                        await ref.read(greenhouseRepositoryProvider).addCropToGreenhouse(id, crop);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Cultivo ${crop.name} agregado al invernadero.')),
                        );
                      } catch (e) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Error al agregar el cultivo: $e')),
                        );
                      }
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
