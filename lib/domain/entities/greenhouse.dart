import 'entities.dart';

class Greenhouse {
  final List<Crop> crops;
  final Details details;
  final List<Sensor> sensors;
  final List<Control> controls;

  Greenhouse({
    required this.crops, 
    required this.details,
    required this.sensors,
    required this.controls,
  });

}