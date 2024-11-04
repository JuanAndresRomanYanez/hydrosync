import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'DASHBOARD', 
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ),
      ),
      body: const Placeholder(),
    );
  }
}