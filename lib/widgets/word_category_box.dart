import 'package:flutter/material.dart';

final pastelColors = {
  'sustantivo': Colors.blue[200],
  'verbo': Colors.amber[300],
  'adjetivo': Colors.green[200],
  'expresión': Colors.pink[100],
};


class WordCategoryBox extends StatelessWidget {
  final String category;

  const WordCategoryBox({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pastelColors[category] ?? Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        child: Text(
          category,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}