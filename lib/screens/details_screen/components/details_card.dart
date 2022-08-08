import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/models/wordModel.dart';

import 'package:app/widgets/word_category_box.dart';

import 'conjugation_tab.dart';
import 'examples.dart';


// fontSize multiplier
const double fontMultiplier = 20.0;


class DetailsCard extends StatelessWidget {
  final WordModel word;
  final double height;

  const DetailsCard({
    Key? key,
    required this.word,
    required this.height
  }) : super(key: key);

  List<Widget> _definitionList(BuildContext context) {
    return [
      // Categoría
      Align(
        alignment: Alignment.centerLeft,
        child: WordCategoryBox(category: word.gramatica),
      ),
      SizedBox(
        height: height * 0.0165,
      ),

      // Definición
      Row(
        children: [
          Text(
            "Significado",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: fontMultiplier * height * 0.0015,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: height * 0.01,
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              word.castellano,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: fontMultiplier * height * 0.001,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: height * 0.0165,
      ),
      // Ejemplos
      (word.ejemplo != '')
        ? Column(
            children: [
              Row(
                children: [
                  Text(
                    "Ejemplos",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: fontMultiplier * height * 0.0015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),

              // Ejemplos
              Examples(examples: word.ejemplo),
              SizedBox(
                height: height * 0.0065,
              ),
            ]
          )
        : Container(),
      (word.gramatica == 'verbo') ? ConjugationTab(verb: word.raiz) : Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      color: Colors.white,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: _definitionList(context),
        ),
      ),
    );
  }
}
