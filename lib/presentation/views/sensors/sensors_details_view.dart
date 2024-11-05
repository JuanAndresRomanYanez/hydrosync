import 'package:flutter/material.dart';

class SensorsDetailsView extends StatelessWidget {

  final int greenhouseId;
  final String sensorId;

  const SensorsDetailsView({
    super.key,
    required this.greenhouseId,
    required this.sensorId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETALLES DEL SENSOR'),
      ),
      body: const Placeholder(),
    );
  }
}
