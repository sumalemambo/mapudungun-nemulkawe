import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';
import 'dart:math';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  var word = "hola";
  late Future<Map<String, dynamic>> _wordData;

  @override
  void initState() {
    _wordData = _fetchWordOfTheDay();
    super.initState();
  }

  Future<Map<String, dynamic>> _fetchWordOfTheDay() async {
    final int nrows = await DatabaseHelper.count(Word.table);
    final int randint = Random(
        DateTime.now().millisecondsSinceEpoch ~/ 86400000
    ).nextInt(nrows - 1) + 1;

    var row = await DatabaseHelper.selectById(
        Word.table,
        WordFields.id,
        [randint]);
    return row.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _wordData,
        builder: (
            BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot
        ) {
          if (snapshot.hasData) {
            var worda = Word.fromMap(snapshot.data!);

            return _FavoriteButton(word: worda);
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final Word word;

  const _FavoriteButton({required this.word});

  @override
  Widget build(BuildContext context) {

    var isInFavorites = context.select<FavoritesProvider, bool>(
        (favorites) => favorites.itemIds.contains(word.id)
    );

    return TextButton(
      onPressed: isInFavorites
          ?  () {
        var favorites = context.read<FavoritesProvider>();
        favorites.remove(word.id!);
      }
          : () {
        // If the item is not in cart, we let the user add it.
        // We are using context.read() here because the callback
        // is executed whenever the user taps the button. In other
        // words, it is executed outside the build method.
        var favorites = context.read<FavoritesProvider>();
        favorites.add(word.id!);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInFavorites
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}