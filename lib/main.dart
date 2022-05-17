import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:csv/csv.dart';
import 'package:app/global_var.dart';
import 'package:app/components/nav.dart';
import 'package:app/models/database_helper.dart';
import 'package:app/models/word_model.dart';


/*
void loadDict() async {
  String path = 'csv/Mapuzuguletuain_2019.csv';
  final _rawData = await rootBundle.loadString(path);
  List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(fieldDelimiter: ';').convert(_rawData);
  rowsAsListOfValues = rowsAsListOfValues.sublist(1, rowsAsListOfValues.length);

  for (final e in rowsAsListOfValues) {
    Word word = Word(theme: e[0], isUnderTheme: e[1],
        word: e[2], translation: e[3],
        image: e[4], definition: e[5],
        conjugation: e[6], declensions: e[7], examples: e[8],
        pronunciation: e[9]);
    await DatabaseHelper.instance.create(word);
  }
}
*/

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await readData();

  runApp(const App());
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