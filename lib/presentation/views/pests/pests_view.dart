import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrosync/presentation/providers/greenhouses/greenhouse_repository_provider.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class PestsView extends ConsumerWidget {
  const PestsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final greenhouses = ref.watch(greenhouseRepositoryProvider).getAllGreenhouses;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('PLAGAS'),
      ),
      body: const Placeholder(),
    );
  }
}