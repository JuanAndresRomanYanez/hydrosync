import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class PestsView extends StatelessWidget {
  const PestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('PLAGAS'),
      ),
      body: const Placeholder(),
    );
  }
}