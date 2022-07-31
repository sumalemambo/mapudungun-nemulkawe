import 'package:flutter/material.dart';

const months = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
];


class DateBox extends StatelessWidget {
  const DateBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = "${now.day} de ${months[now
        .month - 1]} del ${now.year}";
    final width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            today,
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
            ),
            textScaleFactor: 0.8,
          ),
        )
    );
  }
}