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
  List<String> get categories => _wordList.map((data) => data.gramatica).toSet().toList();

  // Obtener filtro de pantallas
  List<WordModel> get filter {
    var _filter = _wordList;

    // Filtro por categoría
    if (_category != '') {
      _filter = _filter.where((word) => word.gramatica == _category).toList();
    }

    // Filtro por letra inicial
    if (_initialLetter != '') {
      if (_initialLetter == 'l') {
        _filter = _filter.where((word) {
          var mapu = word.mapudungun.toLowerCase();
          var condition = mapu.startsWith('l');
          condition = condition && !mapu.startsWith('ll');
          condition = condition && !mapu.startsWith('l\'');
          return condition;
        }).toList();
      }
      else if (_initialLetter == 'n') {
        _filter = _filter.where((word) {
          var mapu = word.mapudungun.toLowerCase();
          var condition = mapu.startsWith('n');
          condition = condition && !mapu.startsWith('n\'');
          return condition;
        }).toList();
      }
      else if (_initialLetter == 't') {
        _filter = _filter.where((word) {
          var mapu = word.mapudungun.toLowerCase();
          var condition = mapu.startsWith('t');
          condition = condition && !mapu.startsWith('tr');
          condition = condition && !mapu.startsWith('t\'');
          return condition;
        }).toList();
      }
      else {
        _filter = _filter.where((word) {
          var mapu = word.mapudungun.toLowerCase();
          return mapu.startsWith(_initialLetter);
        }).toList();
      }
    }

    // Filtro por búsqueda
    if (_query != '') {
      var beginning = _filter.where((word) {
        var mapu = word.mapudungun.toLowerCase();
        return mapu.startsWith(_query);
      }).toList();
      var containing = _filter.where((word) {
        var mapu = word.mapudungun.toLowerCase();
        return mapu.contains(_query) && !mapu.startsWith(_query);
      }).toList();
      var translationContaining = _filter.where((word) {
        var mapu = word.mapudungun.toLowerCase();
        var translation = word.castellano.toLowerCase();
        return translation.contains(_query) && !mapu.contains(_query);
      }).toList();

      // Retornar inmediatamente si hay una query
      return beginning + containing + translationContaining;
    }

    // Retornar aquí si no hay query
    return _filter;
  }
}
