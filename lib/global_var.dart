import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

Map<String, List<List<dynamic>>> data = {};

Future<void> readData() async{
  List<String> names = <String>[
    'augusta',
    'smeets',
    'mapuzuguletuain',
    'harmelink',
  ];
  List<String> paths = <String>[
    'csv/Diccionario_de_Augusta_1916.csv',
    'csv/Ineke_Smeets_2007.csv',
    'csv/Mapuzuguletuain_2019.csv',
    'csv/Vocabulario_Basico_Harmelink.csv',
  ];
  for (var i = 0; i < 4; i++) {
    data[names[i]] = await loadCSV(paths[i]);
  }
}

Future<List<List<dynamic>>> loadCSV(String path) async {
  final _rawData = await rootBundle.loadString(path);
  return const CsvToListConverter(fieldDelimiter: ';').convert(_rawData);
}