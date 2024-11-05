import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/domain/entities/greenhouse.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhousesDetailsView extends ConsumerWidget {
  final int extra;

  const GreenhousesDetailsView({
    super.key, 
    required this.extra
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
          ),
        ),
      ),
      body: const GreenhouseOptions(),
    );
  }
}
