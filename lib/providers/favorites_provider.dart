import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/database/database_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String table = 'Favorites';
  static const String id = '_id';

  List<Word> _item = [];
  List<int> _itemIds = [];
  List<int> get itemIds => _itemIds;
  List<Word> get item => _item;

  Future<void> selectFavoritesIds() async {
    var _ids = await DatabaseHelper.selectAll(table);
    _itemIds = _ids.map((item) => item['_id'] as int).toList();
    notifyListeners();
  }

  Future<void> selectFavorites() async {
    var _ids = await DatabaseHelper.selectAll(table);
    List<int> _idsList = _ids.map((item) => item['_id'] as int).toList();
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

  void add(int id) {
    _itemIds.add(id);
    DatabaseHelper.insert(table, id);
  }
}
