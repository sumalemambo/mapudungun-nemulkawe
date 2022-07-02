import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/providers/favorites_provider.dart';

import 'package:app/database/database_helper.dart';

import 'package:app/models/word_model.dart';

import 'package:app/components/nav.dart';

import 'models/wordModel.dart';

void loadDict() async {

  await DatabaseHelper.dropTable(WordModel.table);

  await DatabaseHelper.createDB2();
  String path = 'csv/nuevo_diccionario2.csv';
  final _rawData = await rootBundle.loadString(path);
  List<List<String>> rowsAsListOfValues = const CsvToListConverter(shouldParseNumbers: false).convert(_rawData);
  //rowsAsListOfValues = rowsAsListOfValues.sublist(1, rowsAsListOfValues.length);
  for (final e in rowsAsListOfValues) {
    WordModel word = WordModel(id: e[0],mapudungun: e[1], gramatica: e[2], castellano: e[3], ejemplo: e[4]);

    await DatabaseHelper.insert_test(WordModel.table, word);
  }
}



// Este Bucket almacena la Scroll Position del Diccionario y los Favoritos
final bucket = PageStorageBucket();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ocultar la barra de estado superior
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // La única orientación posible para la app es vertical, no horizontal
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final wordList = Word.fromList(await DatabaseHelper.selectAll(Word.table));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider(wordList)),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
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
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Here we load the favorites ids into the provider
        future: Provider.of<FavoritesProvider>(context, listen: false).
        loadFavoriteIds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Nav();
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}