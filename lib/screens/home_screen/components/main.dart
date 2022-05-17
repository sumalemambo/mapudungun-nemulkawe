import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/models/database_helper.dart';


class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late Word word;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    wordOfTheDay();
  }

  void wordOfTheDay() async {
    final int nrows = await DatabaseHelper.instance.count(Word.table);
    final int randint = Random(
        DateTime.now().millisecondsSinceEpoch ~/ 86400000
    ).nextInt(nrows - 1) + 1;
    word = await DatabaseHelper.instance.readWord(randint);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: Card(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          elevation: 4.0,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: isLoading
              ? [const Center(child: CircularProgressIndicator(),)]
              : [
                Row(
                  children: [
                    Text(
                      word.word[0].toUpperCase() + word.word.substring(1),
                      style: const TextStyle(
                          fontSize: 45,
                          fontFamily: 'Roboto',
                          color: Colors.black
                      ),
                    )
                  ]
                ),
                Text(
                    word.theme,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Text(
                      "Definicion: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      word.translation,
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}