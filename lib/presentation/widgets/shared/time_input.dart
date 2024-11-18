import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimeInput extends StatefulWidget {
  final Duration initialDuration;
  final ValueChanged<Duration> onDurationChanged;

  const TimeInput({
    super.key,
    required this.initialDuration,
    required this.onDurationChanged,
  });

  @override
  TimeInputState createState() => TimeInputState();
}

class TimeInputState extends State<TimeInput> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    hours = widget.initialDuration.inHours;
    minutes = widget.initialDuration.inMinutes % 60;
    seconds = widget.initialDuration.inSeconds % 60;
  }

  void _updateDuration() {
    final newDuration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    widget.onDurationChanged(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tema actual
    final theme = Theme.of(context);

    // Definir colores utilizando el tema
    final Color labelColor = theme.textTheme.titleMedium?.color ?? Colors.black87;
    final Color backgroundColor = theme.colorScheme.surface;
    final Color borderColor = theme.colorScheme.primary;
    final Color iconColor = theme.colorScheme.primary;

    // Estilos de texto personalizados
    final TextStyle labelTextStyle = theme.textTheme.titleMedium?.copyWith(
      color: labelColor,
      fontWeight: FontWeight.w600,
    ) ?? const TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Horas
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time, color: iconColor),
              const SizedBox(height: 8),
              Text('Horas', style: labelTextStyle),
              NumberPicker(
                minValue: 0,
                maxValue: 23,
                value: hours,
                infiniteLoop: true,
                selectedTextStyle: TextStyle(
                  color: borderColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textStyle: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey,
                  fontSize: 18,
                ),
                onChanged: (value) {
                  setState(() {
                    hours = value;
                    _updateDuration();
                  });
                },
              ),
            ],
          ),
          // Minutos
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time, color: iconColor),
              const SizedBox(height: 8),
              Text('Minutos', style: labelTextStyle),
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: minutes,
                infiniteLoop: true,
                selectedTextStyle: TextStyle(
                  color: borderColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textStyle: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey,
                  fontSize: 18,
                ),
                onChanged: (value) {
                  setState(() {
                    minutes = value;
                    _updateDuration();
                  });
                },
              ),
            ],
          ),
          // Segundos
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time, color: iconColor),
              const SizedBox(height: 8),
              Text('Segundos', style: labelTextStyle),
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: seconds,
                infiniteLoop: true,
                selectedTextStyle: TextStyle(
                  color: borderColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textStyle: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey,
                  fontSize: 18,
                ),
                onChanged: (value) {
                  setState(() {
                    seconds = value;
                    _updateDuration();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
