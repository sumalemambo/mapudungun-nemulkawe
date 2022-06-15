import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';
import '../../../database/database_helper.dart';
import '../../../models/word_model.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with AutomaticKeepAliveClientMixin {
  late Future<List<Word>> _wordData;
  late var favorites;

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    _wordData = _fetchFavorites();
    super.initState();
  }

  Future<List<Word>> _fetchFavorites() async {
    var favorites = context.read<FavoritesProvider>();

    final _ids = favorites.itemIds;
    final rows = await DatabaseHelper.selectById(
        Word.table,
        WordFields.id,
        _ids);

    return Word.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      future: _wordData,
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Word>> snapshot
      ) {
        if (snapshot.hasData) {
          var favorites_list = snapshot.data!;
          return Container(
              height: 500.0,
              child: Card(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  elevation: 4.0,
                  child: ListView.builder(
                    // La PageStorageKey almacena la Scroll Position de la lista
                    key: PageStorageKey<String>('Favoritos'),
                    itemCount: favorites_list.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          leading: Text(favorites_list[i].theme),
                          title: Text(favorites_list[i].word),
                          subtitle: Text(favorites_list[i].translation),
                          trailing: _FavoriteButton(word: favorites_list[i]),
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