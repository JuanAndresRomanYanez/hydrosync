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
    final theme = Theme.of(context);

    return Card(
      elevation: 4, // Sombra para la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: InkWell(
        onTap: onButtonPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con nombre del cultivo superpuesto
            Stack(
              children: [
                // Imagen del cultivo
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                // Degradado para mejorar la legibilidad del texto
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Nombre del cultivo
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    cropName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
                          blurRadius: 10.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Descripción del cultivo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: theme.textTheme.bodyMedium, // Utiliza el estilo del tema
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
