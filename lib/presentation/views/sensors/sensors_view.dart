import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';
import 'package:hydrosync/presentation/providers/providers.dart';

class SensorsView extends ConsumerWidget {
  final int id;

  const SensorsView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SENSORES'),
      ),
      body: greenhousesAsyncValue.when(
        data: (greenhouses) {
          // Buscar el invernadero por id
          final greenhouse = greenhouses.firstWhere(
            (g) => g.details.id == id,
          );

          // Accedemos a los sensores del invernadero
          final sensors = greenhouse.sensors;

          // Crear la lista de datos de sensores para las tarjetas
          final List<Map<String, dynamic>> sensorsData = sensors.map((sensor) {
            return {
              'id': sensor.id, // Aseguramos que 'id' esté incluido
              'name': sensor.name,
              'value': sensor.value,
              'image': sensor.image,
            };
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView.builder(
              itemCount: sensorsData.length,
              itemBuilder: (context, index) {
                final sensor = sensorsData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SensorCard(
                    imageUrl: sensor['image'].toString(),
                    value: sensor['value'],
                    sensorName: sensor['name'].toString(),
                    sensorId: sensor['id'].toString(),
                    onButtonPressed: () {
                      context.push(
                        '/greenhouses/details/sensors/config',
                        extra: {
                          'greenhouseId': id,
                          'sensorId': sensor['id'].toString(),
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
