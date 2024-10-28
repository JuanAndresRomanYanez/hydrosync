import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('DASHBOARD'),
      ),
      body: const Placeholder(),
    );
  }
}