import 'package:flutter/material.dart';
import 'package:app/models/wordModel.dart';
import 'package:app/database/database_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String table = 'FavoritesTable';
  static const String id = 'wordId';


  List<String> _itemIds = [];
  List<String> get itemIds => _itemIds;

  List<WordModel> _item = [];
  List<WordModel> get item => _item;

  void add(String id) {
    _itemIds.add(id);
    addFavorite(id);

    notifyListeners();
  }

  void remove(String id) {
    _itemIds.remove(id);
    removeFavorite(id);

    notifyListeners();
  }

  Future<void> loadFavoriteIds() async {
    var _ids = await DatabaseHelper.selectAll(table);

    _itemIds = (_ids.map((item) => item['wordId']).toList()).cast<String>();
    _itemIds.remove('');
  }

  Future<void> removeFavorite(String id) async {
    DatabaseHelper.deleteWhere(table, 'wordId', id);
  }

  Future<void> addFavorite(String id) async {
    Map<String, dynamic> map = {
      'wordId': id,
    };
    DatabaseHelper.insert(table, map);
  }
  
  Future<void> selectFavorites() async {
    var _ids = await DatabaseHelper.selectAll(table);
    List<String> _idsList = [];
    for (final e in _ids) {
      _idsList.add(e[id]);
    }
    var dataList = await DatabaseHelper.selectById2(
        WordModel.table,
        WordModelFields.id,
        _idsList
    );
    _item = dataList
        .map((item) => WordModel(
        id: item['id'],
        mapudungun: item['mapudungun'],
        raiz: item['raiz'],
        gramatica: item['gramatica'],
        castellano: item['castellano'],
        ejemplo: item['ejemplo'],
        )
    ).toList();
    notifyListeners();
  }
}
