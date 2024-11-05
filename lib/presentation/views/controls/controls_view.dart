import 'package:flutter/material.dart';

class ControlsView extends StatelessWidget {

  final int id;

  const ControlsView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTROLES'),
      ),
      body: const Placeholder(),
    );
  }
}