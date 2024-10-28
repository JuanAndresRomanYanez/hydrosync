import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class SensorsView extends StatelessWidget {
  const SensorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('SENSORES'),
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