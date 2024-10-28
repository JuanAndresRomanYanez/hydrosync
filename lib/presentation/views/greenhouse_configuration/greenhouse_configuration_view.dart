import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/widgets.dart';

class GreenhouseConfigurationView extends StatelessWidget {
  const GreenhouseConfigurationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('CONFIGURACIÓN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); // Regresa a la vista anterior
          },
        ),
      ),
      body: const Placeholder(),
    );
  }
}