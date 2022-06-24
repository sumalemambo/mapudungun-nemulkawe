import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

import '../../../database/database_helper.dart';
import '../../../models/word_model.dart';

import 'favorites_header.dart';
import 'favorites_list.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Word>> _wordData;

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
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const FavoritesHeader(),
                  const SizedBox(height: 8.0),
                  FavoritesList(favoritesList: favoritesList),
                ],
              )
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
