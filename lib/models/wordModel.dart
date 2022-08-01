import 'package:app/models/abstract_model.dart';

/// We'll use this class to map between the fields of the Word class
/// and the corresponding columns names in the database table.
class WordModelFields {
  static final List<String> values = [
    // Add all fields
    id, mapudungun, raiz, gramatica, castellano, ejemplo
  ];

  // Each field is associated with its corresponding column name
  static const String id = 'id';
  static const String mapudungun = 'mapudungun';
  static const String raiz = 'raiz';
  static const String gramatica = 'gramatica';
  static const String castellano = 'castellano';
  static const String ejemplo = 'ejemplo';
}

/// Class that defines the structures for the dictionary words
class WordModel extends AbstractModel {
  // Name of the table in the database that will hold the Words model
  static String table = 'WordTable';

  final String mapudungun;
  final String raiz;
  final String gramatica;
  final String castellano;
  final String ejemplo;

  // Class constructor
  WordModel({
    String? id,
    required this.mapudungun,
    required this.raiz,
    required this.gramatica,
    required this.castellano,
    required this.ejemplo,
  }) : super(id);

  /// Create Word object using map ({String: object} dictionary)
  static WordModel fromMap(Map<String, dynamic> map) {
    return WordModel(
        id: map[WordModelFields.id] as String?,
        mapudungun: map[WordModelFields.mapudungun] as String,
        raiz: map[WordModelFields.raiz] as String,
        gramatica: map[WordModelFields.gramatica] as String,
        castellano: map[WordModelFields.castellano] as String,
        ejemplo: map[WordModelFields.ejemplo] as String
    );
  }

  /// Create a list of words objects from map (n: {String: object} dictionary)
  static List<WordModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((item) => WordModel(
        id: item[WordModelFields.id] as String?,
        mapudungun: item[WordModelFields.mapudungun] as String,
        raiz: item[WordModelFields.raiz] as String,
        gramatica: item[WordModelFields.gramatica] as String,
        castellano: item[WordModelFields.castellano] as String,
        ejemplo: item[WordModelFields.ejemplo] as String
    )).toList();
  }

  @override
  /// Create map ({String: object} dictionary) from a Word instance fields
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      WordModelFields.id: id,
      WordModelFields.mapudungun: mapudungun,
      WordModelFields.raiz: raiz,
      WordModelFields.gramatica: gramatica,
      WordModelFields.castellano: castellano,
      WordModelFields.ejemplo: ejemplo,
    };
    return map;
  }
}