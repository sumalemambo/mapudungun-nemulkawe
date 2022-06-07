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
  late Future<List<Word>> _wordData;

  @override
  void initState() {
    _wordData = _fetchWords();
    super.initState();
  }

  Future<List<Word>> _fetchWords() async {
    final rows = await DatabaseHelper.fetchInterval(
        Word.table,
        WordFields.id,
        0,
        15
    );

    return Word.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Word>>(
        future: _wordData,
        builder: (
            BuildContext context,
            AsyncSnapshot<List<Word>> snapshot
        ) {
          if (snapshot.hasData) {
            var wordList = snapshot.data!;
            return ListView.builder(
              itemCount: wordList.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    leading: Text(wordList[i].theme),
                    title: Text(wordList[i].word),
                    subtitle: Text(wordList[i].translation),
                    trailing: _FavoriteButton(word: wordList[i]),
                  ),
                );
              },
            );
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

    return IconButton(
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