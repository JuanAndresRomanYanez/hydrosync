import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhousesDetailsView extends StatelessWidget {
  const GreenhousesDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('DETALLES DEL INVERNADERO'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); // Regresa a la vista anterior
          },
        ),
      ),
      body: const GreenhouseOptions(),
    );
  }
}
