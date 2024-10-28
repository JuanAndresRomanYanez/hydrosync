import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class CropsView extends StatelessWidget {
  const CropsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('CULTIVOS'),
      ),
      body: const Placeholder(),
    );
  }
}