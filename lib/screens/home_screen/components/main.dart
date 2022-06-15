import 'package:app/models/word_model.dart';
import 'package:app/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/database/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with AutomaticKeepAliveClientMixin {
  late Future<Map<String, dynamic>> _wordData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _wordData = _fetchWordOfTheDay();
    super.initState();
  }

  int todayToInt() {
    var now = DateTime.now();
    int today = now.year * 10000 + now.month * 100 + now.day;
    return today;
  }

  Future<Map<String, dynamic>> _fetchWordOfTheDay() async {
    final int nrows = await DatabaseHelper.count(Word.table);
    final int numberOfTheDay = Random(todayToInt()).nextInt(nrows);

    var row = await DatabaseHelper.selectById(
        Word.table,
        WordFields.id,
        [numberOfTheDay]
    );

    return row.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _wordData,
        builder: (
            BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot
            ) {
          if (snapshot.hasData) {
            var word = snapshot.data![WordFields.word];
            var theme = snapshot.data![WordFields.theme];
            var definition = snapshot.data![WordFields.definition];
            return Card(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                color: Colors.red[50],
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            word,
                            style: GoogleFonts.openSans(
                              fontSize: 45,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            theme,
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );


    /* return Container(
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

     */
  }
}