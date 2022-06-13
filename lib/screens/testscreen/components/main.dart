import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  //final wordList = [];
  late Future<List<Word>> _wordData;

  @override
  void initState() {
    _wordData = _fetchWords();
    super.initState();
  }

  Future<List<Word>> _fetchWords() async {
    final rows = await DatabaseHelper.selectAll(Word.table);
    /*
    final rows = await DatabaseHelper.fetchRange(
        Word.table,
        0,
        20
    );
    */

    return Word.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      future: _wordData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var wordList = snapshot.data!;
          return Container(
              height: 500.0,
              child: Card(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  elevation: 4.0,
                  child: ListView.builder(
                    itemCount: wordList.length,
                    itemBuilder: (context, i) {
                      /*
                      if (i >= wordList.length - 25) {
                        DatabaseHelper.fetchRange(
                          Word.table,
                          wordList.length,
                          wordList.length + 50,
                        ).then(
                          (rows) {
                            wordList.addAll(Word.fromList(rows));
                          }
                        );
                      }
                      */
                      return Card(
                        child: ListTile(
                          leading: Text(wordList[i].theme),
                          title: Text(wordList[i].word),
                          subtitle: Text(wordList[i].translation),
                          trailing: _FavoriteButton(word: wordList[i]),
                        ),
                      );
                    },
                  )
              )
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }
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

    return IconButton(
      onPressed: isInFavorites
          ?  () {
        var favorites = context.read<FavoritesProvider>();
        print(favorites.item);
        print(favorites.itemIds);
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
      icon: isInFavorites
          ? const Icon(
            Icons.favorite,
            color: Colors.pink,
            semanticLabel: 'ADDED'
          )
          : const Icon(Icons.favorite, color: Colors.grey,),
    );
  }
}