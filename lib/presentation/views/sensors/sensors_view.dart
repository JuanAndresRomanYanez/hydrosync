import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class SensorsView extends StatelessWidget {
  const SensorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('SENSORES'),
      ),
      body: const Placeholder(),
    );
  }
}