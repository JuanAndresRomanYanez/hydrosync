import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hydrosync/domain/entities/greenhouse.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhouseCard extends ConsumerWidget {
  final Greenhouse greenhouse;

  const GreenhouseCard({
    super.key, 
    required this.greenhouse
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color(0xFF45C4DD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Text(
                greenhouse.details.name,
                textAlign: TextAlign.center, // Centrar el texto
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20), // Espacio entre el título y la información
            
            // Carrusel de imágenes
             // Carrusel de imágenes con desplazamiento automático
            if (greenhouse.crops.isNotEmpty)
              AutoScrollImageCarousel(
                imagePaths: greenhouse.crops.map((crop) => crop.image).toList(),
              ),

            const SizedBox(height: 20,),
            // Uso de `InformativeDataRow` para mostrar cada dato
            InformativeDataRow(
              label: 'Ubicación', 
              value: greenhouse.details.location
            ),
            InformativeDataRow(
              label: 'Tamaño', 
              value: greenhouse.details.size
            ),
            InformativeDataRow(
              label: 'Estado', 
              value: greenhouse.details.status
            ),

            const SizedBox(height: 20), // Espacio antes de los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  label: 'Ver más',
                  icon: Icons.visibility,
                  color: Colors.blue,
                  onPressed: () {
                    context.push(
                      '/greenhouses/details',
                      extra: greenhouse.details.id,
                    );
                  },
                ),
                const SizedBox(width: 15),
                ActionButton(
                  label: 'Editar',
                  icon: Icons.edit,
                  color: Colors.green,
                  onPressed: () {
                    context.push(
                      '/greenhouses/edit',
                      extra: greenhouse.details.id,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
