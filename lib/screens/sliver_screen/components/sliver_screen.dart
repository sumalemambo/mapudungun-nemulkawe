import 'package:flutter/material.dart';
import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';
import 'main.dart';
import 'search_bar.dart';
import 'verb_conjugator.dart';



class SliverScreen extends StatelessWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.selectAll(Word.table),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data! as List<Map<String, dynamic>>;
          final wordList = Word.fromList(list);
          return Card(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            elevation: 4.0,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 160.0,

                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return Card(
                          child: ListTile(
                            leading: Text(wordList[i].theme),
                            title: Text(wordList[i].word),
                            subtitle: Text(wordList[i].translation),
                            trailing: _FavoriteButton(word: wordList[i]),
                          ),
                        );
                      }
                  )
                ),
              ],
            ),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
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

