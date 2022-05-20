import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/models/database_helper.dart';
import 'package:app/models/model.dart';

class Favorites extends Model {
  static const String table = "Favorites";

  Favorites({
    int? id
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      '_id': id
    };
    return map;
  }
}

class FavoritesProvider extends ChangeNotifier {
  List<Word> _item = [];

  List<Word> get item => _item;

  Future<void> selectFavorites() async {
    var _ids = await DatabaseHelper.selectAll("Favorites");
    var _idsList = [];
    for (final e in _ids) {
      _idsList.add(e);
    }
    print(_idsList);
  }
}
