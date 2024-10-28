import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('REPORTES'),
      ),
      body: const Placeholder(),
    );
  }
}