import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
            padding: const EdgeInsets.only(bottom: 16.0),
            itemCount: crops.length,
            itemBuilder: (context, index) {
              final crop = crops[index];
              return CropCard(
                imageUrl: crop.image,
                description: crop.description,
                cropName: crop.name,
                onCardPressed: () {
                  // Acción al presionar la tarjeta
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Detalles de ${crop.name}')),
                  );
                },
                onDeletePressed: () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: Text('¿Estás seguro de que deseas eliminar el cultivo "${crop.name}" del invernadero?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    try {
                      await ref.read(greenhouseRepositoryProvider).removeCropFromGreenhouse(id, crop.id);
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Cultivo "${crop.name}" eliminado del invernadero.')),
                      );
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Error al eliminar el cultivo: $e')),
                      );
                    }
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón
          // Navegar a la vista de agregar cultivo
          context.push(
            '/greenhouses/details/crops/add',
            extra: id,
          );
        },
        tooltip: 'Agregar Cultivo',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

