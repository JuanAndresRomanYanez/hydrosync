import 'package:flutter/material.dart';
import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class ControlsOptions extends StatelessWidget {
  final int id; // ID del invernadero
  final List<Control> controls;

  const ControlsOptions({
    super.key,
    required this.id,
    required this.controls,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controls.length,
      itemBuilder: (context, index) {
        final control = controls[index];
        return ControlOptionCard(
          id: id,
          control: control,
          imagePath: 'assets/images/more/${control.image}', // Asegúrate de tener una propiedad 'image' en tu entidad Control
        );
      },
    );
  }
}
