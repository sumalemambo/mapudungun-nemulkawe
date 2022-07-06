import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

import '../../database/database_helper.dart';
import '../../models/wordModel.dart';

import 'components/favorites_header.dart';
import 'components/favorites_list.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<WordModel>> _wordData;

  @override
  void initState() {
    _wordData = _fetchFavorites();
    super.initState();
  }

  Future<List<WordModel>> _fetchFavorites() async {
    var favorites = context.read<FavoritesProvider>();

    final _ids = favorites.itemIds;
    final rows = await DatabaseHelper.selectById2(
        WordModel.table,
        WordModelFields.id,
        _ids);

    return WordModel.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WordModel>>(
      future: _wordData,
      builder: (context, snapshot) {
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
