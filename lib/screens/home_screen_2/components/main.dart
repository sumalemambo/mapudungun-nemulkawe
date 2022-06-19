import 'package:app/models/word_model.dart';
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
    final int nRows = await DatabaseHelper.count(Word.table);
    final int numberOfTheDay = Random(todayToInt()).nextInt(nRows);

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
      height: 550.0,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _wordData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var word = snapshot.data![WordFields.word];
            var theme = snapshot.data![WordFields.theme];
            var definition = snapshot.data![WordFields.definition];
            return Card(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                elevation: 4.0,
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      child: ListTile(
                        title: Text(
                          "Palabra del día",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          //mainAxisSize: MainAxisSize.min,
                          //mainAxisAlignment: MainAxisAlignment.start,
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
                      ),
                    ),
                  ],
                ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}