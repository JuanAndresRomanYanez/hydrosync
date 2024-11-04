import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/entities/entities.dart';
// import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhousesDetailsView extends ConsumerWidget {
  final String greenhouse;

  const GreenhousesDetailsView({
    super.key, 
    required this.greenhouse,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'DETALLES DEL INVERNADERO', 
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ),
      ),
      body: const Placeholder(),
      // body: const GreenhouseOptions(),
    );
  }
}
