import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/presentation/providers/providers.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class ControlDetailsView extends ConsumerStatefulWidget {
  final int greenhouseId;
  final String controlId;

  const ControlDetailsView({
    super.key,
    required this.greenhouseId,
    required this.controlId,
  });

  @override
  ControlDetailsViewState createState() => ControlDetailsViewState();
}

class ControlDetailsViewState extends ConsumerState<ControlDetailsView> {
  late Control currentControl;
  bool isLoading = true;

  // Duraciones para el tiempo encendido y apagado
  Duration onDuration = Duration.zero;
  Duration offDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadControlData();
  }

  Future<void> _loadControlData() async {
    final greenhouses = await ref.read(greenhousesStreamProvider.future);
    final greenhouse = greenhouses.firstWhere((g) => g.details.id == widget.greenhouseId);

    currentControl = greenhouse.controls.firstWhere((c) => c.id == widget.controlId);

    // Configurar las duraciones
    setState(() {
      onDuration = Duration(seconds: currentControl.onTime);
      offDuration = Duration(seconds: currentControl.offTime);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final inputTextStyle = theme.textTheme.bodyLarge;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentControl.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Modo de Operación
              CustomDropdownFormField<String>(
                value: currentControl.mode,
                labelText: 'Modo de Operación',
                items: const [
                  DropdownMenuItem(value: 'manual', child: Text('Manual')),
                  DropdownMenuItem(value: 'automatic', child: Text('Automático')),
                ],
                onChanged: (value) {
                  setState(() {
                    currentControl = Control(
                      id: currentControl.id,
                      name: currentControl.name,
                      image: currentControl.image,
                      mode: value!,
                      status: currentControl.status,
                      onTime: currentControl.onTime,
                      offTime: currentControl.offTime,
                    );
                  });
                },
                inputTextStyle: inputTextStyle,
              ),
              const SizedBox(height: 16),
              if (currentControl.mode == 'manual') ...[
                // Modo manual
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estado del control: ${currentControl.status ? 'Encendido' : 'Apagado'}'),
                    ElevatedButton(
                      onPressed: () async {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        try {
                          // Cambiar el estado del control
                          final newStatus = !currentControl.status;
                          final updatedControl = Control(
                            id: currentControl.id,
                            name: currentControl.name,
                            image: currentControl.image,
                            mode: currentControl.mode,
                            status: newStatus,
                            onTime: currentControl.onTime,
                            offTime: currentControl.offTime,
                          );
        
                          await ref.read(greenhouseRepositoryProvider).updateControlData(
                                widget.greenhouseId,
                                currentControl.id,
                                updatedControl,
                              );
        
                          setState(() {
                            currentControl = updatedControl;
                          });
        
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text('${currentControl.name} ${newStatus ? 'encendido' : 'apagado'} correctamente.'),
                            ),
                          );
                        } catch (e) {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(content: Text('Error al actualizar el estado: $e')),
                          );
                        }
                      },
                      child: Text(currentControl.status ? 'Apagar' : 'Encender'),
                    ),
                  ],
                ),
              ] else ...[
                // Modo automático
                const SizedBox(height: 16),
                const Text('Tiempo encendido'),
                TimeInput(
                  initialDuration: onDuration,
                  onDurationChanged: (newDuration) {
                    setState(() {
                      onDuration = newDuration;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text('Tiempo apagado'),
                TimeInput(
                  initialDuration: offDuration,
                  onDurationChanged: (newDuration) {
                    setState(() {
                      offDuration = newDuration;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    try {
                      final onTimeSeconds = onDuration.inSeconds;
                      final offTimeSeconds = offDuration.inSeconds;
        
                      final updatedControl = Control(
                        id: currentControl.id,
                        name: currentControl.name,
                        image: currentControl.image,
                        mode: currentControl.mode,
                        status: currentControl.status,
                        onTime: onTimeSeconds,
                        offTime: offTimeSeconds,
                      );
        
                      await ref.read(greenhouseRepositoryProvider).updateControlData(
                            widget.greenhouseId,
                            currentControl.id,
                            updatedControl,
                          );
        
                      setState(() {
                        currentControl = updatedControl;
                      });
        
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Configuración actualizada correctamente.')),
                      );
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Error al actualizar la configuración: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: inputTextStyle?.copyWith(fontSize: 25),
                  ),
                  child: const Text('Guardar Configuración'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
