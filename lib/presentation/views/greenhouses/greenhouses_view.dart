import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

import '../../providers/greenhouses/greenhouse_repository_provider.dart';

class GreenhousesView extends ConsumerWidget {
  const GreenhousesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greenhousesAsyncValue = ref.watch(greenhousesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'INVERNADEROS',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: greenhousesAsyncValue.when(
          data: (greenhouses) => ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            itemCount: greenhouses.length,
            itemBuilder: (context, index) {
              final greenhouse = greenhouses[index];
              return Column(
                children: [
                  GreenhouseCard(greenhouse: greenhouse),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
