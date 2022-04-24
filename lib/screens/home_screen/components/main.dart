import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:math';
import 'package:app/global_var.dart';

Future<String> fetchWord() async {
  final _rawData = await rootBundle.loadString("csv/Mapuzuguletuain_2019.csv");
  List<List<dynamic>> _listData =
  const CsvToListConverter(fieldDelimiter: ';').convert(_rawData);
  return _listData[1][2];
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final int randint = Random(
      (DateTime.now().millisecondsSinceEpoch + DateTime.now().timeZoneOffset.inMilliseconds) ~/ 86400000
  ).nextInt(data['harmelink']!.length - 1) + 1;

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
            children: [
              Text(data['harmelink']![randint][2].toString()),
              Text(data['harmelink']![randint][3].toString()),
            ],
          ),
        ),
      )
    );
  }
}