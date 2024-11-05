import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/providers/providers.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class CropsView extends ConsumerWidget {
  final int id;

  const CropsView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CULTIVOS'),
      ),
      body: greenhousesAsyncValue.when(
        data: (greenhouses) {
          // Buscar el invernadero por id
          final greenhouse = greenhouses.firstWhere(
            (g) => g.details.id == id,
          );

          // Accedemos a los cultivos del invernadero
          final crops = greenhouse.crops;

          // Verificamos si hay cultivos
          if (crops.isEmpty) {
            return const Center(child: Text('No hay cultivos disponibles.'));
          }

          // Mostrar la lista de cultivos
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 16.0), // Agrega un padding inferior si lo deseas
            itemCount: crops.length,
            itemBuilder: (context, index) {
              final crop = crops[index];
              return CropCard(
                imageUrl: crop.image,
                description: crop.description,
                cropName: crop.name,
                onButtonPressed: () {
                  // Acción al presionar la tarjeta
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Detalles de ${crop.name}')),
                  );
                },
              );
            },
          );

        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

}
