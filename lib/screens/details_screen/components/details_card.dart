import 'package:flutter/material.dart';

import 'package:app/models/word_model.dart';

import 'definition_tab.dart';
import 'conjugation_tab.dart';

// fontSize multiplier
const double fontMultiplier = 20.0;


class DetailsCard extends StatelessWidget {
  final Word word;

  const DetailsCard({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                        DefinitionTab(word: word),
                      ]
                      : [
                        DefinitionTab(word: word),
                        DefinitionTab(word: word),
                      ],
                  ),
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}