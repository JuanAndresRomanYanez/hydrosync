import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhouseCard extends StatelessWidget {
  const GreenhouseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF45C4DD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
        side: const BorderSide(
          color: Colors.black, // Color del borde
          width: 2.0, // Grosor del borde
        ),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30), // Espacio interno dentro de la tarjeta
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Center(
              child: Text(
                'INVERNADERO 1',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GreenhouseDataDetails(),
            const SizedBox(height: 20),

            // Botones "Ver más" y "Editar"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón Ver más con ícono de ojo
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/greenhouses/details');
                  },
                  icon: const Icon(Icons.visibility, color: Colors.black),
                  label: const Text(
                    'Ver más',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      side: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre botones

                // Botón Editar con ícono de lápiz
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción para el botón de editar
                    context.push('/greenhouses/edit');
                  },
                  icon: const Icon(Icons.edit, color: Colors.black),
                  label: const Text(
                    'Editar',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      side: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
