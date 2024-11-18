
class Control {
  final String id;  
  final String name;
  final String image; 
  final String mode; // manual o automatico
  final bool status; // true: encendido, false: apagado (para modo manual)
  final int onTime; // tiempo encendido en segundos (para modo automático)
  final int offTime; // tiempo apagado en segundos (para modo automático)

  Control({
    required this.id,
    required this.name,
    required this.image,
    required this.mode,
    required this.status,
    required this.onTime,
    required this.offTime,
  });
  
}