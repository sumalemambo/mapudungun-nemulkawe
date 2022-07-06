import 'package:flutter/material.dart';
import 'package:app/models/wordModel.dart';

class SearchProvider with ChangeNotifier {
  final List<WordModel> _wordList;

  String _query = '';
  String _initialLetter = '';
  String _category = '';

  SearchProvider(this._wordList);

  void setQuery(String newQuery) {
    _query = newQuery.toLowerCase();
    notifyListeners();
  }

  void setInitialLetter(String newInitialLetter) {
    _initialLetter = newInitialLetter.toLowerCase();
    notifyListeners();
  }

  void setCategory(String newCategory) {
    _category = newCategory;
    notifyListeners();
  }

  // Obtener todas las palabras
  List<WordModel> get wordList => _wordList;

  // Obtener las categorías
  List<String> get categories {
    var cat = _wordList.map((data) => data.gramatica).toSet().toList();
    cat.remove('');
    return cat;
  }

  // Obtener filtro de pantallas
  List<WordModel> get filter {
    var _filter = _wordList;

    // Filtro por categoría
    if (_category != '') {
      _filter = _filter.where((data) => data.gramatica == _category).toList();
    }

    // Filtro por letra inicial
    if (_initialLetter != '') {
      if (_initialLetter == 'l') {
        _filter = _filter.where((data) {
          var word = data.mapudungun.toLowerCase();
          var condition = word.startsWith('l');
          condition = condition && !word.startsWith('ll');
          condition = condition && !word.startsWith('lh');
          return condition;
        }).toList();
      }
      else if (_initialLetter == 'n') {
        _filter = _filter.where((data) {
          var word = data.mapudungun.toLowerCase();
          var condition = word.startsWith('n');
          condition = condition && !word.startsWith('nh');
          return condition;
        }).toList();
      }
      else if (_initialLetter == 't') {
        _filter = _filter.where((data) {
          var word = data.mapudungun.toLowerCase();
          var condition = word.startsWith('t');
          condition = condition && !word.startsWith('tx');
          return condition;
        }).toList();
      }
      else {
        _filter = _filter.where((data) {
          var word = data.mapudungun.toLowerCase();
          return word.startsWith(_initialLetter);
        }).toList();
      }
    }

    // Filtro por búsqueda
    if (_query != '') {
      var beginning = _filter.where((data) {
        var word = data.mapudungun.toLowerCase();
        return word.startsWith(_query);
      }).toList();
      var containing = _filter.where((data) {
        var word = data.mapudungun.toLowerCase();
        return word.contains(_query) && !word.startsWith(_query);
      }).toList();
      var translationContaining = _filter.where((data) {
        var word = data.mapudungun.toLowerCase();
        var translation = data.castellano.toLowerCase();
        return translation.contains(_query) && !word.contains(_query);
      }).toList();

      // Retornar inmediatamente si hay una query
      return beginning + containing + translationContaining;
    }

    // Retornar aquí si no hay query
    return _filter;
  }
}
