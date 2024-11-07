import 'package:flutter/material.dart';
import 'package:hydrosync/domain/entities/entities.dart';

class CropAddCard extends StatelessWidget {
  final Crop crop;
  final VoidCallback onAddPressed;

  const CropAddCard({
    super.key,
    required this.crop,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(crop.image),
          radius: 30,
        ),
        title: Text(
          crop.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onAddPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: Colors.green,
          ),
          child: const Text('Agregar'),
        ),
      ),
    );
  }
}
