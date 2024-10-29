import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GreenhouseDataDetails extends StatelessWidget {
  final DatabaseReference _invernaderoRef =
      FirebaseDatabase.instance.ref().child('greenhouses/greenhouse_1/details');

  GreenhouseDataDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _invernaderoRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final dataSnapshot = snapshot.data?.snapshot.value as Map?;
        final data = dataSnapshot?.cast<String, dynamic>();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Nombre: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: '${data?['name'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Ubicación: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: '${data?['location'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Tamaño: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: '${data?['size'] ?? 'N/A'} m^2',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Estado: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: '${data?['status'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
