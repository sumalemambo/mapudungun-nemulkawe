import 'package:app/models/wordModel.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/database/database_helper.dart';
import 'package:app/screens/details_screen/main.dart';


class WordOfTheDayCard extends StatefulWidget {
  const WordOfTheDayCard({Key? key}) : super(key: key);

  @override
  State createState() => _WordOfTheDayCardState();
}

class _WordOfTheDayCardState extends State<WordOfTheDayCard> with AutomaticKeepAliveClientMixin {
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
    final int nRows = await DatabaseHelper.count(WordModel.table);
    final int numberOfTheDay = Random(todayToInt()).nextInt(nRows);

    var row = await DatabaseHelper.selectByIndex(
        WordModel.table,
        numberOfTheDay,
    );

    return row.first;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ancho = MediaQuery.of(context).size.width;
    return FutureBuilder<Map<String, dynamic>>(
      future: _wordData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var word = WordModel.fromMap(snapshot.data!);
          return Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(ancho * 0.08),
              child: Column(
                children: <Widget>[

                  Image.asset('assets/day.png',height: ancho * 0.3,width: ancho * 0.3),
                  Text(
                    word.mapudungun,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: ancho * 0.1,
                      color: const Color(0xff47455f),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    word.gramatica,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: ancho * 0.06,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Significado: ' + word.castellano,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: ancho * 0.04,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(height: ancho * 0.045),
                  ElevatedButton(
                    child: Text(
                        "Detalles...",
                    style: TextStyle(
                      fontSize: ancho * 0.06
                    )),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                        padding: EdgeInsets.all(ancho * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(word: word)
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}