import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hydrosync/domain/entities/entities.dart';

class ControlOptionCard extends StatelessWidget {
  final int id; // ID del invernadero
  final Control control;
  final String imagePath;

  const ControlOptionCard({
    super.key,
    required this.id,
    required this.control,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la vista de detalles del control
        context.push(
          '/greenhouses/details/controls/details',
          extra: {'greenhouseId': id, 'controlId': control.id},
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            control.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
