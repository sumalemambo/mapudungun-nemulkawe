import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/models/database_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String table = 'Favorites';
  static const String id = '_id';

  List<Word> _item = [];
  List<Word> get item => _item;

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
