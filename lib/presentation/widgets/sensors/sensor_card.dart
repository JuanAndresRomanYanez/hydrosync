import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final String imageUrl;
  final dynamic value;
  final String sensorName;
  final String sensorId;
  final VoidCallback onButtonPressed;

  const SensorCard({
    super.key,
    required this.imageUrl,
    required this.value,
    required this.sensorName,
    required this.sensorId,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Formateamos el valor según el 'sensorId'
    String formattedValue;

    if (sensorId == 'temperature') {
      int intValue = _parseToInt(value);
      formattedValue = '$intValue°C';
    } else if (sensorId == 'humidity') {
      int intValue = _parseToInt(value);
      formattedValue = '$intValue%';
    } else if (sensorId == 'light') {
      double doubleValue = _parseToDouble(value);
      int percentage = (doubleValue / 10).round();
      formattedValue = '$percentage%';
    } else if (sensorId == 'water') {
      int intValue = _parseToInt(value);
      formattedValue = '$intValue cm';
    } else {
      formattedValue = value.toString();
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFBBDEFB),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: const Color(0xFF1976D2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              sensorName,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    formattedValue,
                    style: const TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onButtonPressed,
                icon: const Icon(Icons.visibility, color: Colors.white),
                label: const Text(
                  'Más detalles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Métodos auxiliares para parsear valores
  int _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else {
      return int.tryParse(value.toString()) ?? 0;
    }
  }

  double _parseToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      return double.tryParse(value.toString()) ?? 0.0;
    }
  }
}
