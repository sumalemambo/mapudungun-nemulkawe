import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/models/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/models/favorites.dart';


class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

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

    /* This code is for testing purposes
    var test = await DatabaseHelper.selectById(Word.table, WordFields.id,
        [1, 2]);
    for (final e in test) {
      Word t = Word.fromMap(e);
      print(t.translation);
    }
    var _ids = await DatabaseHelper.selectAll("Favorites");
    List<int> _idsList = [];
    for (final e in _ids) {
      _idsList.add(e['_id']);
    }
    print(_idsList);
     */
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        child: Card(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          color: Colors.red[50],
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
                      style: GoogleFonts.openSans(
                          fontSize: 45,
                          color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ]
                ),
                Text(
                    word.theme,
                    style: GoogleFonts.openSans(
                      fontSize: 18,
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
                        style: GoogleFonts.openSans()
                    )
                  ],
                ),
                Row(

                )
              ],
            ),
          ),
        )
    );
  }


}