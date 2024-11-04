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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // GreenhouseDataDetails(greenhouse: greenhouse),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: () {
            //         context.push(
            //           '/greenhouses/details',
            //           extra: greenhouse,
            //         );
            //       },
            //       icon: const Icon(Icons.visibility, color: Colors.black),
            //       label: const Text(
            //         'Ver más',
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.green,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(45.0),
            //           side: const BorderSide(color: Colors.black, width: 2.0),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     ElevatedButton.icon(
            //       onPressed: () {
            //         context.push(
            //           '/greenhouses/edit',
            //           extra: greenhouse,
            //         );
            //       },
            //       icon: const Icon(Icons.edit, color: Colors.black),
            //       label: const Text(
            //         'Editar',
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.orange,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(45.0),
            //           side: const BorderSide(color: Colors.black, width: 2.0),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
