import 'package:flutter/material.dart';

final pastelColors = {
  'sustantivo': Colors.blue[200],
  'verbo': Colors.orange[200],
  'adjetivo': Colors.green[200],
  'expresión': Colors.pink[100],
};


class WordCategoryBox extends StatelessWidget {
  final String category;
  final double height;

  const WordCategoryBox({
    Key? key,
    required this.category,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pastelColors[category] ?? Colors.grey,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        child: Text(
          category,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}