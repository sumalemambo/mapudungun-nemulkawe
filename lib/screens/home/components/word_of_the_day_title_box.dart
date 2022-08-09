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
          borderRadius: BorderRadius.circular(height * 0.01),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(height * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Fachiantüchi n\'emül',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: fontMultiplier * height * 0.0015,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Palabra del día',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: fontMultiplier * height * 0.0015,
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