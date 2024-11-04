import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhousesDetailsView extends StatelessWidget {
  const GreenhousesDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'DETALLES DEL INVERNADERO', 
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ),
      ),
      body: const GreenhouseOptions(),
    );
  }
}
