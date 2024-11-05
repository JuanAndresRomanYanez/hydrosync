import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/providers/providers.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

import '../../../domain/entities/entities.dart';

class SensorsConfigView extends ConsumerStatefulWidget {
  final int greenhouseId;
  final String sensorId;

  const SensorsConfigView({
    super.key,
    required this.greenhouseId,
    required this.sensorId,
  });

  @override
  SensorsDetailsViewState createState() => SensorsDetailsViewState();
}

class SensorsDetailsViewState extends ConsumerState<SensorsConfigView> {
  late TextEditingController minValueController;
  late TextEditingController maxValueController;
  late TextEditingController updateFrequencyController;

  bool isInitialized = false;

  @override
  void dispose() {
    minValueController.dispose();
    maxValueController.dispose();
    updateFrequencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURAR SENSOR'),
      ),
      body: greenhousesAsyncValue.when(
        data: (greenhouses) {
          // Buscar el invernadero por id
          final greenhouse = greenhouses.firstWhere(
            (g) => g.details.id == widget.greenhouseId,
          );

          // Buscar el sensor por id
          final sensor = greenhouse.sensors.firstWhere(
            (s) => s.id == widget.sensorId,
          );

          if (!isInitialized) {
            minValueController = TextEditingController(text: sensor.minValue.toString());
            maxValueController = TextEditingController(text: sensor.maxValue.toString());
            updateFrequencyController = TextEditingController(text: sensor.updateFrequency.toString());

            isInitialized = true;
          }

          // Estilos de texto
          final labelTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 25);
          final inputTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20);

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  sensor.name,
                  style: const TextStyle(
                    fontSize: 25, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: minValueController,
                  labelText: 'Valor Mínimo',
                  labelStyle: labelTextStyle,
                  inputTextStyle: inputTextStyle,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: maxValueController,
                  labelText: 'Valor Máximo',
                  labelStyle: labelTextStyle,
                  inputTextStyle: inputTextStyle,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: updateFrequencyController,
                  labelText: 'Frecuencia de Actualización',
                  labelStyle: labelTextStyle,
                  inputTextStyle: inputTextStyle,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    try {
                      final updatedSensor = Sensor(
                        id: sensor.id,
                        name: sensor.name,
                        image: sensor.image,
                        value: sensor.value,
                        minValue: double.tryParse(minValueController.text) ?? sensor.minValue,
                        maxValue: double.tryParse(maxValueController.text) ?? sensor.maxValue,
                        updateFrequency: double.tryParse(updateFrequencyController.text) ?? sensor.updateFrequency,
                      );

                      await ref.read(greenhouseRepositoryProvider).updateSensorData(
                        widget.greenhouseId,
                        sensor.id,
                        updatedSensor,
                      );

                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Sensor actualizado')),
                      );

                      // Opcionalmente, navegar hacia atrás
                      // if (mounted) Navigator.of(context).pop();
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Error al actualizar: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: inputTextStyle?.copyWith(fontSize: 25),
                  ),
                  child: const Text('Guardar cambios'),
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
