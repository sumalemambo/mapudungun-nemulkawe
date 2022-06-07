import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/database/database_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String table = 'Favorites';
  static const String id = '_id';


  List<int> _itemIds = [];
  List<int> get itemIds => _itemIds;

  List<Word> _item = [];
  List<Word> get item => _item;

  void add(int id) {
    _itemIds.add(id);
    addFavorite(id);

    notifyListeners();
  }

  void remove(int id) {
    _itemIds.remove(id);
    removeFavorite(id);

    notifyListeners();
  }

  Future<void> loadFavoriteIds() async {
    var _ids = await DatabaseHelper.selectAll(table);

    _itemIds = (_ids.map((item) => item['_id']).toList()).cast<int>();
  }

  Future<void> removeFavorite(int id) async {
    DatabaseHelper.delete(table, id);
  }

  Future<void> addFavorite(int id) async {
    Map<String, dynamic> map = {
      WordFields.id: id,
    };
    DatabaseHelper.insert(table, map);
  }
  
  Future<void> selectFavorites() async {
    var _ids = await DatabaseHelper.selectAll(table);
    List<int> _idsList = [];
    for (final e in _ids) {
      _idsList.add(e[id]);
    }
    var dataList = await DatabaseHelper.selectById(
        Word.table,
        WordFields.id,
        _idsList
    );
    _item = dataList
        .map((item) => Word(
        id: item['_id'],
        theme: item['theme'],
        isUnderTheme: item['isUnderTheme'],
        word: item['word'],
        translation: item['translation'],
        definition: item['definition'],
        conjugation: item['conjugation'],
        declensions: item['declensions'],
        examples: item['examples'],
        pronunciation: item['pronunciation']
        )).toList();
    notifyListeners();
  }
}
