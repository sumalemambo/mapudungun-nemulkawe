import 'package:flutter/material.dart';

// fontSize multiplier
const double fontMultiplier = 20.0;

class WordOfTheDayTitleBox extends StatelessWidget {
  final double height;

  const WordOfTheDayTitleBox({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Fachiantüchi n\'emül',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 28.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Palabra del día',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}