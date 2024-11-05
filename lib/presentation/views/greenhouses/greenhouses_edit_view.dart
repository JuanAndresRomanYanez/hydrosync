import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/providers/providers.dart';

class GreenhousesEditView extends ConsumerWidget {
  final int extra;

  const GreenhousesEditView({
    super.key, 
    required this.extra
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'EDICIÓN DEL INVERNADERO',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: greenhousesAsyncValue.when(
        data: (greenhouses) {
          // Buscamos el invernadero específico por nombre
          final greenhouse = greenhouses.firstWhere(
            (g) => g.details.id == extra,
          );


          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${greenhouse.details.name}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Ubicación: ${greenhouse.details.location}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Tamaño: ${greenhouse.details.size}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Estado: ${greenhouse.details.status}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
