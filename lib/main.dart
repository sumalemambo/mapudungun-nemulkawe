import 'package:app/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/components/nav.dart';
import 'package:provider/provider.dart';

/*
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:csv/csv.dart';
import 'package:app/models/database_helper.dart';
import 'package:app/models/word_model.dart';

void loadDict() async {
  String path = 'csv/Mapuzuguletuain_2019.csv';
  final _rawData = await rootBundle.loadString(path);
  List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(fieldDelimiter: ';').convert(_rawData);
  rowsAsListOfValues = rowsAsListOfValues.sublist(1, rowsAsListOfValues.length);

  for (final e in rowsAsListOfValues) {
    Word word = Word(theme: e[0], isUnderTheme: e[1],
        word: e[2], translation: e[3], definition: e[5],
        conjugation: e[6], declensions: e[7], examples: e[8],
        pronunciation: e[9]);
    await DatabaseHelper.instance.create(word);
  }
}
 */

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ],
        child: const App(),
      )
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: FutureBuilder(
        future: Provider.of<FavoritesProvider>(context, listen: false).
        loadFavoriteIds(),
        builder: (
            BuildContext context,
            AsyncSnapshot<void> snapshot
        ) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Nav();
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}