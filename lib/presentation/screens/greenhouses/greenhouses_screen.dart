// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// // import 'package:hydrosync/presentation/widgets/greenhouses/greenhouse_card.dart';
// import 'package:hydrosync/presentation/widgets/widgets.dart';

// class GreenhousesScreen extends StatelessWidget {
  
//   static const name = 'greenhouses-screen';

//   final DatabaseReference _invernaderoRef = FirebaseDatabase.instance.ref().child('greenhouse_2/sensors');

//   GreenhousesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('INVERNADEROS'),
//         leading: const Icon(Icons.menu),
//       ),
//       body: StreamBuilder<DatabaseEvent>(
//         stream: _invernaderoRef.onValue,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           final dataSnapshot = snapshot.data?.snapshot.value as Map?;
//           final data = dataSnapshot?.cast<String, dynamic>();

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Temperatura: ${data?['temperature']['value'] ?? 'N/A'} °C", style: TextStyle(fontSize: 18)),
//                 Text("Humedad: ${data?['humidity']['value'] ?? 'N/A'} %", style: TextStyle(fontSize: 18)),
//                 Text("Distancia: ${data?['waterLevel']['value'] ?? 'N/A'} cm", style: TextStyle(fontSize: 18)),
//               ],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: const CustomBottomNavigation(),
//     );
//   }
// }