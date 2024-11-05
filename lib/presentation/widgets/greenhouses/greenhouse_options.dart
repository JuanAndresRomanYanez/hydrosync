import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhouseOptions extends StatelessWidget {
  final int id;

  const GreenhouseOptions({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          GreenhouseOptionCard(
            id: id,
            label: 'CULTIVOS',
            imagePath: 'assets/images/more/crops.png',
            route: '/greenhouses/details/crops',
          ),
          const SizedBox(height: 16),
          GreenhouseOptionCard(
            id: id,
            label: 'SENSORES',
            imagePath: 'assets/images/more/sensors.png',
            route: '/greenhouses/details/sensors',
          ),
          const SizedBox(height: 16),
          GreenhouseOptionCard(
            id: id,
            label: 'CONTROLES',
            imagePath: 'assets/images/more/controls.png',
            route: '/greenhouses/details/controls',
          ),
        ],
      ),
    );
  }
}
