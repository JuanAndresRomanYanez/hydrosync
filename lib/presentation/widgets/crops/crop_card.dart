import 'package:flutter/material.dart';

class CropCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String cropName;
  final VoidCallback onButtonPressed;

  const CropCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.cropName,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFBBDEFB), // Fondo azul claro
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: const Color(0xFF1976D2), // Borde azul oscuro
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3), // Sombra sutil
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nombre del cultivo
            Text(
              cropName,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Imagen del cultivo
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // Descripción del cultivo
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Botón para ver más detalles
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: onButtonPressed,
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(vertical: 12.0),
            //       backgroundColor: Colors.deepOrangeAccent,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12.0),
            //       ),
            //     ),
            //     child: const Text(
            //       'Más detalles',
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
