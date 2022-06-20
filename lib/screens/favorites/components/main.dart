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
    super.build(context);
    return FutureBuilder<List<Word>>(
      future: _wordData,
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Word>> snapshot
      ) {
        if (snapshot.hasData) {
          var favoritesList = snapshot.data!;
          return SizedBox(
              height: 400.0,
              child: Card(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.red,
                        child: const ListTile(
                          title: Text(
                            "Favoritos",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            )
                          ),
                        ),
                      ),
                      Expanded(
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
                        ),
                      ),
                    ],
                  ),
              )
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}
