import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hydrosync/presentation/widgets/widgets.dart';

class SensorsDetailsView extends StatelessWidget {
  const SensorsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('DETALLES DEL SENSOR'),
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
