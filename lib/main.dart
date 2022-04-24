import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import 'package:app/components/nav.dart';

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

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await readData();
  runApp(const App());
  print(data['augusta']);
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Nav(),
    );
  }
}