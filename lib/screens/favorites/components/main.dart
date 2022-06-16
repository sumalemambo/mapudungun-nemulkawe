import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';
import 'package:app/widgets/favorite_button.dart';
import '../../../database/database_helper.dart';
import '../../../models/word_model.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with AutomaticKeepAliveClientMixin {
  late Future<List<Word>> _wordData;

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
          var favoritesList = snapshot.data!;
          return SizedBox(
              height: 500.0,
              child: Card(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  elevation: 4.0,
                  child: ListView.builder(
                    // La PageStorageKey almacena la Scroll Position de la lista
                    key: const PageStorageKey<String>('Favoritos'),
                    itemCount: favoritesList.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          leading: Text(favoritesList[i].theme),
                          title: Text(favoritesList[i].word),
                          subtitle: Text(favoritesList[i].translation),
                          trailing: FavoriteButton(word: favoritesList[i]),
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
