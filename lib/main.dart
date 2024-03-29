import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/providers/favorites_provider.dart';
import 'package:app/database/database_helper.dart';
import 'package:app/components/nav.dart';
import 'models/wordModel.dart';

// Este Bucket almacena la Scroll Position del Diccionario y los Favoritos
final bucket = PageStorageBucket();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // La única orientación posible para la app es vertical, no horizontal
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final wordList = WordModel.fromList(
      await DatabaseHelper.selectAll(WordModel.table)
  );

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            // Here we load the favorites ids into the provider
              future: Provider.of<FavoritesProvider>(context, listen: false)
              .loadFavoriteIds(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Nav();
                }
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
          ),
        ),
      ),
    );
  }
}