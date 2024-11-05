import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/providers/providers.dart';

import '../../../domain/entities/entities.dart';

class GreenhousesEditView extends ConsumerStatefulWidget {
  final int extra;

  const GreenhousesEditView({
    super.key,
    required this.extra,
  });

  @override
  GreenhousesEditViewState createState() => GreenhousesEditViewState();
}

class GreenhousesEditViewState extends ConsumerState<GreenhousesEditView> {
  late TextEditingController nameController;
  late TextEditingController locationController;

  // Variables para almacenar las selecciones
  String? selectedSize;
  String? selectedStatus;

  bool isInitialized = false;

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          final greenhouse = greenhouses.firstWhere(
            (g) => g.details.id == widget.extra,
          );

          if (!isInitialized) {
            nameController = TextEditingController(text: greenhouse.details.name);
            locationController = TextEditingController(text: greenhouse.details.location);

            // Inicializar las selecciones con los valores actuales
            selectedSize = greenhouse.details.size;
            selectedStatus = greenhouse.details.status;

            isInitialized = true;
          }

          // Obtener el estilo de texto predeterminado del tema
          final TextStyle? labelTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 25);
          final TextStyle? inputTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20);
          final TextStyle? dropdownTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18);

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: labelTextStyle,
                  ),
                  style: inputTextStyle,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Ubicación',
                    labelStyle: labelTextStyle,
                  ),
                  style: inputTextStyle,
                ),
                const SizedBox(height: 10),

                // Menú desplegable para "Tamaño"
                DropdownButtonFormField<String>(
                  value: selectedSize,
                  decoration: InputDecoration(
                    labelText: 'Tamaño',
                    labelStyle: labelTextStyle,
                  ),
                  style: inputTextStyle,
                  items: ['Pequeño', 'Mediano', 'Grande']
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text(
                              size,
                              style: dropdownTextStyle,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Menú desplegable para "Estado"
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    labelStyle: labelTextStyle,
                  ),
                  style: inputTextStyle,
                  items: ['Activo', 'Inactivo']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(
                              status,
                              style: dropdownTextStyle,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    // Capturamos el ScaffoldMessengerState antes del await
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    final updatedDetails = Details(
                      location: locationController.text,
                      name: nameController.text,
                      size: selectedSize ?? greenhouse.details.size,
                      status: selectedStatus ?? greenhouse.details.status,
                      id: greenhouse.details.id,
                    );

                    try {
                      await ref
                          .read(greenhouseRepositoryProvider)
                          .updateGreenhouseDetails(greenhouse.details.id, updatedDetails);

                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Detalles actualizados')),
                      );

                      // Opcionalmente, puedes navegar hacia atrás después de guardar
                      // if (mounted) Navigator.of(context).pop();
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Error al actualizar: $e')),
                      );
                    }
                  },
                  child: Text(
                    'Guardar cambios',
                    style: inputTextStyle?.copyWith(fontSize: 25),
                  ),
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
