import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final String imageUrl;
  final String value;
  final String sensorName;
  final VoidCallback onButtonPressed;

  const SensorCard({
    super.key,
    required this.imageUrl,
    required this.value,
    required this.sensorName,
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
            // Nombre del sensor centrado en la parte superior
            Text(
              sensorName,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Fila con la imagen y el valor del sensor
            Row(
              children: [
                // Imagen más grande
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),

                // Dato grande (valor del sensor) con estilo resaltado
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Botón más grande y destacado
            SizedBox(
              width: double.infinity, // Botón que ocupe el ancho completo
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Más detalles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
