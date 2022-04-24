import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
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
              Text(data['mapuzuguletuain']![1][0]),
              Text(data['mapuzuguletuain']![1][1]),
              Text(data['mapuzuguletuain']![1][2]),
              Text(data['mapuzuguletuain']![1][3]),
              Text(data['mapuzuguletuain']![1][4]),
              Text(data['mapuzuguletuain']![1][5]),
              Text(data['mapuzuguletuain']![1][6])
            ],
          ),
        ),
      )
    );
  }
}