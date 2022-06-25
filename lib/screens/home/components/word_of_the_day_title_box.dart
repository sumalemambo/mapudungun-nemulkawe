import 'package:flutter/material.dart';


class WordOfTheDayTitleBox extends StatelessWidget {
  const WordOfTheDayTitleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
    );
  }
}