import 'package:flutter/material.dart';

const weekdays = [
  'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
];
const months = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
];

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = "${weekdays[now.weekday-1]}, ${now.day} de ${months[now.month-1]} del ${now.year}";

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            today,
            style: const TextStyle(color: Colors.grey, fontSize: 13.0),
          ),
          const Text(
              'Palabra del Día',
                style: TextStyle(fontSize: 33.0),
          ),
        ],
      ),
    );
  }
}