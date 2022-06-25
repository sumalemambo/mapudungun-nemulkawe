import 'package:flutter/material.dart';

const weekdays = [
  'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
];
const months = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
];


class DateBox extends StatelessWidget {
  const DateBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = "${weekdays[now.weekday - 1]}, ${now.day} de ${months[now
        .month - 1]} del ${now.year}";

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            today,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            textScaleFactor: 0.8,
          ),
        )
    );
  }
}