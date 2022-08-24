import 'package:app/models/wordModel.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/database/database_helper.dart';
import 'package:app/screens/details_screen/main.dart';
import 'package:app/widgets/word_category_box.dart';
import 'package:app/widgets/img_avatar.dart';

// fontSize multiplier
const double fontMultiplier = 20.0;

class WordOfTheDayCard extends StatefulWidget {
  final double height;
  const WordOfTheDayCard({
    Key? key,
    required this.height,
  }) : super(key: key);

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
    final Random numberOfTheDay = Random(todayToInt());

    var row = await DatabaseHelper.selectByIndex(
        WordModel.table,
        numberOfTheDay.nextInt(nRows),
    );
    while (row.isEmpty) {
      row = await DatabaseHelper.selectByIndex(
        WordModel.table,
        numberOfTheDay.nextInt(nRows),
      );
    }

    return row.first;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = widget.height;
    final width = MediaQuery.of(context).size.width;
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
              padding: EdgeInsets.all(height * 0.05),
              child: Column(
                children: <Widget>[
                  ImgAvatar(imgPath: 'assets/imgs/${word.id}.png'),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    child: Column(
                      children: [
                        Text(
                          word.mapudungun,
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 36.0, //0.1
                            color: Color(0xff47455f),
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        WordCategoryBox(category: word.gramatica, height: 24.0),
                        const SizedBox(height: 12.0),
                        Text(
                          'Significado: ' + word.castellano,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 16.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    child: const Text(
                      "Detalles...",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                        padding: const EdgeInsets.all(16.0),
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