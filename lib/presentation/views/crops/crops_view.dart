import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class CropsView extends StatelessWidget {
  final int id;

  final DatabaseReference _cropsRef = FirebaseDatabase.instance.ref().child('greenhouses/greenhouse_1/crops');

  CropsView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CULTIVOS'),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: _cropsRef.onValue,
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

          // Lista de datos de cultivos para pasar a las tarjetas
          final List<Map<String, dynamic>> cropsData = data.entries.map((entry) {
            final crop = entry.value;

            // Verifica si 'crop' es de tipo Map
            if (crop is Map) {
              return {
                'name': crop['name'] ?? 'Nombre desconocido',
                'description': crop['description'] ?? 'Sin descripción',
                'image': crop['image'] ?? 'assets/images/crops/default.png', // Imagen por defecto
              };
            } else {
              // Manejo de error en caso de que la entrada no sea un mapa
              return {
                'name': 'Nombre desconocido',
                'description': 'Sin descripción',
                'image': 'assets/images/crops/default.png',
              };
            }
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView.builder(
              itemCount: cropsData.length,
              itemBuilder: (context, index) {
                final crop = cropsData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CropCard(
                    imageUrl: crop['image'],
                    description: crop['description'],
                    cropName: crop['name'],
                    onButtonPressed: () {
                      // Acción del botón, muestra un mensaje temporal en este caso
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Detalles de ${crop['name']}')),
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
