import 'package:flutter/material.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhousesView extends StatelessWidget {

  const GreenhousesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('INVERNADEROS', style: TextStyle(fontSize: 30, ),)),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Espacio alrededor de la tarjeta
        // Aqui debo poner la lista de invernaderos luego
        child: ListView(
          
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
          children: const [
            GreenhouseCard(),
            SizedBox(height: 20,),
            GreenhouseCard(),
            SizedBox(height: 20,),
            GreenhouseCard(),
          ],
        ),
      ),

    );
  }
}