import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/domain/entities/greenhouse.dart';

class GreenhouseCard extends StatelessWidget {
  final Greenhouse greenhouse;

  const GreenhouseCard({super.key, required this.greenhouse});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF45C4DD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                greenhouse.details.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el título y la información
            const Text(
              'Ubicación: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              greenhouse.details.location,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10), // Espacio entre la ubicación y el tamaño
            const Text(
              'Tamaño: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              greenhouse.details.size.toString(), // Asegúrate de que size sea un String
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10), // Espacio entre el tamaño y el estado
            const Text(
              'Estado: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              greenhouse.details.status,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20), // Espacio antes de los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(
                      '/greenhouses/details',
                      extra: greenhouse,
                    );
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
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(
                      '/greenhouses/edit',
                      extra: greenhouse,
                    );
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
