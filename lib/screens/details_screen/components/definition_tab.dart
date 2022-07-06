import 'package:flutter/material.dart';

import 'package:app/models/wordModel.dart';
import 'package:app/widgets/favorite_button.dart';

// fontSize multiplier
const double fontMultiplier = 20.0;


class DefinitionTab extends StatelessWidget {
  final WordModel word;

  const DefinitionTab({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          word.gramatica,
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey
          ),
        ),
        SizedBox(
          height: height * 0.0165,
        ),
        Row(
          children: [
            Text(
              "Definición ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontMultiplier * height * 0.0015,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Flexible(
            child: Text(
                word.castellano,
                style: TextStyle(fontSize: fontMultiplier * height * 0.001)
            )
        ),
        SizedBox(
          height: height * 0.0165,
        ),
        Row(
          children: [
            Text(
              "Ejemplos",
              style: TextStyle(
                fontSize: fontMultiplier * height * 0.0015,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Flexible(
            child: Text(
              word.ejemplo,
              style: TextStyle(fontSize: fontMultiplier * height * 0.001),
            )
        ),
        SizedBox(
          height: height * 0.065,
        ),
        Center(
          child: FavoriteButton(word: word),
        ),
      ],
    );
  }
}