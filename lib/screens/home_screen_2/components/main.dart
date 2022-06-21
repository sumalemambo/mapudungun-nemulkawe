import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/database/database_helper.dart';
import 'package:app/screens/details_screen/components/main.dart';

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
      height: 320,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _wordData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = Word.fromMap(snapshot.data!);
            var word = snapshot.data![WordFields.word];
            var theme = snapshot.data![WordFields.theme];
            var definition = snapshot.data![WordFields.translation];
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    Image.asset('lib/assets/day.png',height: 100,width: 100),
                    Text(
                      word,
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 44,
                        color: Color(0xff47455f),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      theme,
                      style: const TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 23,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Traducción: '+definition,
                      style: const TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                    ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (
                                context) => DetailScreen(
                                word: data)),);}, child: Text('Más información...'))
                  ],
                ),
              )
              
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