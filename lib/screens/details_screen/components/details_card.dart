import 'package:flutter/material.dart';

import 'package:app/models/word_model.dart';


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
    return [
      Row(
        children: [
          Text(
            word.theme,
            style: TextStyle(
                fontSize: fontMultiplier * height * 0.001,
                fontStyle: FontStyle.italic,
                color: Colors.grey
            ),
          ),
        ],
      ),
      SizedBox(
        height: height * 0.0165,
      ),
      SizedBox(
        height: height * 0.01,
      ),
      Row(
          children: [
            Expanded(
                child: Text(
                  word.translation,
                  style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: fontMultiplier * height * 0.001
                  ),
                )
            ),
          ]
      ),
      SizedBox(
        height: height * 0.0165,
      ),
      Row(
        children: [
          Text(
            "Ejemplos",
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: fontMultiplier * height * 0.0015,
              fontWeight: FontWeight.bold,
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
                  word.examples,
                  style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: fontMultiplier * height * 0.001),
                )
            ),
          ]
      ),
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
            children: _definitionList(context)
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
