import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'REPORTES', 
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