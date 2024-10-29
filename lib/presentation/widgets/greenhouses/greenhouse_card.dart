import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhouseCard extends StatelessWidget {
  const GreenhouseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
          color: const Color(0xFF45C4DD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
            side: const BorderSide(
              color: Colors.black, // Color del borde
              width: 2.0, // Grosor del borde
            ),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(30), // Espacio interno dentro de la tarjeta
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                const Center(
                  child: Text(
                    'INVERNADERO 1',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Image.asset(
                //   'assets/images/crops/lechuga.png',
                //   height: 200,
                //   width: double.infinity,
                // ),

                // Sliver (Icono o Imagen)
                // const Icon(
                //   Icons.image,
                //   size: 60,
                //   color: Colors.blueAccent,
                // ),
                const SizedBox(height: 10),

                GreenhouseDataDetails(),

                // Botón
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/greenhouses/details');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                        side: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                    child: const Text('Ver más', style: TextStyle(color: Colors.black),),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}