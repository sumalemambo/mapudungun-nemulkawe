import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/models/word_model.dart';

import 'conjugation_tab.dart';


// fontSize multiplier
const double fontMultiplier = 20.0;


class DetailsCard extends StatelessWidget {
  final Word word;
  final double height;

  const DetailsCard({
    Key? key,
    required this.word,
    required this.height
  }) : super(key: key);

  List<Widget> _definitionList(BuildContext context) {
    late List<List<String>> examples;
    if (word.examples != '') {
      examples = word.examples.split(";").map((example) {
        return example.split('‘').map((element) => element.substring(0, element.length-1).trim()).toList();
      }).toList();
    }

    return [
      // Categoría
      Row(
        children: [
          Text(
            word.theme,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: fontMultiplier * height * 0.001
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: height * 0.0165,
      ),

      // Definición
      Row(
        children: [
          Text(
            "Definición",
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
              word.translation,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: fontMultiplier * height * 0.001
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
      (word.examples != '')
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
              // Cada uno de los ejemplos
              Column(
                children: List.generate(examples.length, (i) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "• " + examples[i][0],
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: fontMultiplier * height * 0.001
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              examples[i][1],
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: const Color(0xFF888888),
                                    fontStyle: FontStyle.italic,
                                    fontSize: fontMultiplier * height * 0.001
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ]
                  );

                }),
              ),

            ]
          )
        : Container(),
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
          children: [
            ..._definitionList(context),
            const SizedBox(height: 16.0),
            (word.theme == 'Verbos') ? ConjugationTab(word: word) : Container(),
          ]
        ),
      )
    );
    /*
    return Container(
      constraints: BoxConstraints(
          minHeight: height * 0.45,
          minWidth: double.infinity,
          maxHeight: double.infinity
      ),
      child: Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        color: Colors.white,
        elevation: 4.0,
        child: DefaultTabController(
          length: word.theme == 'Verbos' ? 3 : 2,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: TabBar(
                  tabs: word.theme == 'Verbos'
                    ? const [
                      Tab(text: 'Definición'),
                      Tab(text: 'Conjugación'),
                      Tab(text: 'Notas')
                    ]
                    : const [
                      Tab(text: 'Definición'),
                      Tab(text: 'Notas')
                    ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 300.0,
                  child: TabBarView(
                    children: word.theme == 'Verbos'
                      ? [
                        DefinitionTab(word: word),
                        ConjugationTab(word: word),
                        NotesTab(word: word),
                      ]
                      : [
                        DefinitionTab(word: word),
                        NotesTab(word: word),
                      ],
                  ),
                ),
              ),
            ]
          )
        ),
      ),
    );
     */
  }
}
