import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GreenhouseOptionButton extends StatelessWidget {
  final String label;
  final Color color;
  final String route;

  const GreenhouseOptionButton({
    super.key,
    required this.label,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 8,
      
      child: ElevatedButton(
        onPressed: () => context.push(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
            side: const BorderSide(color: Colors.black, width: 2.0), // Aquí defines el borde
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 35),
        ),
      ),
    );
  }
}