import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class SensorsView extends StatelessWidget {
  final DatabaseReference _invernaderoRef = FirebaseDatabase.instance.ref().child('greenhouses/greenhouse_1/sensors');

  SensorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('SENSORES'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); // Regresa a la vista anterior
          },
        ),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: _invernaderoRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // Obtenemos los datos del snapshot
          final dataSnapshot = snapshot.data?.snapshot.value as Map?;
          final data = dataSnapshot?.cast<String, dynamic>();

          // Validamos si los datos existen
          if (data == null) {
            return const Center(child: Text("No hay datos disponibles."));
          }

          // Lista de datos de sensores para pasar a las tarjetas
          final List<Map<String, dynamic>> sensorsData = [
            {
              'name': 'Temperatura',
              'value': '${data['temperature']['value'] ?? 'N/A'} °C',
              'image': 'assets/images/sensors/temperatura.png',
            },
            {
              'name': 'Humedad',
              'value': '${data['humidity']['value'] ?? 'N/A'} %',
              'image': 'assets/images/sensors/humedad.png',
            },
            {
              'name': 'Distancia',
              'value': '${data['waterLevel']['value'] ?? 'N/A'} cm',
              'image': 'assets/images/sensors/nivel_de_agua.png',
            },
            {
              'name': 'Luz del ambiente',
              'value': '${data['ambientLight']['value'] ?? 'N/A'} %',
              'image': 'assets/images/sensors/luz_ambiente.png',
            },
          ];

          return Padding(
            padding: const EdgeInsets.all(30.0), // Espacio alrededor de la tarjeta
            child: ListView.builder(
              itemCount: sensorsData.length,
              itemBuilder: (context, index) {
                final sensor = sensorsData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SensorCard(
                    imageUrl: sensor['image'],
                    value: sensor['value'],
                    sensorName: sensor['name'],
                    onButtonPressed: () {
                      // Aquí podrías definir la acción del botón, por ejemplo, navegar a más detalles
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Detalles de ${sensor['name']}')),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
