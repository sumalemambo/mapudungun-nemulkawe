import 'package:app/models/abstract_model.dart';

/// We'll use this class to map between the fields of the Word class
/// and the corresponding columns names in the database table.
class WordModelFields {
  static final List<String> values = [
    // Add all fields
    id, title, chillka, grammar, gram,
    definition, examples
  ];

  // Each field is associated with its corresponding column name
  static const String id = 'id';
  static const String title = 'title';
  static const String chillka = 'chillka';
  static const String grammar = 'grammar';
  static const String gram = 'gram';
  static const String definition = 'definition';
  static const String examples = 'examples';
}

/// Class that defines the structures for the dictionary words
class WordModel extends AbstractModel {
  // Name of the table in the database that will hold the Words model
  static String table = 'WordTable';

  final String title;
  final String chillka;
  final String grammar;
  final String gram;
  final String definition;
  final String examples;

  // Class constructor
  WordModel({
    String? id,
    required this.title,
    required this.chillka,
    required this.grammar,
    required this.gram,
    required this.definition,
    required this.examples,
  }) : super(id);

  /// Create Word object using map ({String: object} dictionary)
  static WordModel fromMap(Map<String, dynamic> map) {
    return WordModel(
        id: map[WordModelFields.id] as String?,
        title: map[WordModelFields.title] as String,
        chillka: map[WordModelFields.chillka] as String,
        grammar: map[WordModelFields.grammar] as String,
        gram: map[WordModelFields.gram] as String,
        definition: map[WordModelFields.definition] as String,
        examples: map[WordModelFields.examples] as String
    );
  }

  /// Create a list of words objects from map (n: {String: object} dictionary)
  static List<WordModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((item) => WordModel(
        id: item[WordModelFields.id] as String?,
        title: item[WordModelFields.title] as String,
        chillka: item[WordModelFields.chillka] as String,
        grammar: item[WordModelFields.grammar] as String,
        gram: item[WordModelFields.gram] as String,
        definition: item[WordModelFields.definition] as String,
        examples: item[WordModelFields.examples] as String
    )).toList();
  }

  @override
  /// Create map ({String: object} dictionary) from a Word instance fields
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      WordModelFields.id: id,
      WordModelFields.title: title,
      WordModelFields.chillka: chillka,
      WordModelFields.grammar: grammar,
      WordModelFields.gram: gram,
      WordModelFields.definition: definition,
      WordModelFields.examples: examples,
    };
    return map;
  }
}