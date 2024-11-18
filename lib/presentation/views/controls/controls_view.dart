import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/providers/providers.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class ControlsView extends ConsumerWidget {
  final int id; // ID del invernadero

  const ControlsView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTROLES'),
      ),
      body: greenhousesAsyncValue.when(
        data: (greenhouses) {
          // Buscar el invernadero por id
          final greenhouse = greenhouses.firstWhere(
            (g) => g.details.id == id,
          );

          // Accedemos a los controles del invernadero
          final controls = greenhouse.controls;

          // Verificamos si hay controles
          if (controls.isEmpty) {
            return const Center(child: Text('No hay controles disponibles.'));
          }

          // Mostrar la lista de controles
          return ControlsOptions(
            id: id,
            controls: controls,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
