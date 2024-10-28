import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhouseOptions extends StatelessWidget {
  const GreenhouseOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: const [
          SizedBox(height: 30),
          GreenhouseOptionButton(
            label: 'CULTIVOS',
            color: Color(0xFFB2DFDB),
            route: '/greenhouses/details/crops',
          ),
          SizedBox(height: 80),
          GreenhouseOptionButton(
            label: 'SENSORES',
            color: Color(0xFFBBDEFB),
            route: '/greenhouses/details/sensors',
          ),
          SizedBox(height: 80),
          GreenhouseOptionButton(
            label: 'CONTROLES',
            color: Color(0xFFFFF9C4),
            route: '/greenhouses/details/controls',
          ),
          SizedBox(height: 80),
          GreenhouseOptionButton(
            label: 'CONFIGURACIÓN',
            color: Color(0xFFE1BEE7),
            route: '/greenhouses/details/configuration',
          ),
        ],
      ),
    );
  }
}
