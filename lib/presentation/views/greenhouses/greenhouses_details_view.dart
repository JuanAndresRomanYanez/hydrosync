import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhousesDetailsView extends ConsumerWidget {
  final int id;

  const GreenhousesDetailsView({
    super.key, 
    required this.id
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
      body: GreenhouseOptions(id: id,),
    );
  }
}
