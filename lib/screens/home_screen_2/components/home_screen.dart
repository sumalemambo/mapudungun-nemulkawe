import 'package:flutter/material.dart';
import 'main.dart';

const weekdays = [
  'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
];
const months = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
];


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              DateBox(),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: WordOfTheDayTitle(),
        ),
        const Main(),
      ],
    );
  }
}

class DateBox extends StatelessWidget {
  const DateBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = "${weekdays[now.weekday-1]}, ${now.day} de ${months[now.month-1]} del ${now.year}";

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

class WordOfTheDayTitle extends StatelessWidget {
  const WordOfTheDayTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              'Palabra del día',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}