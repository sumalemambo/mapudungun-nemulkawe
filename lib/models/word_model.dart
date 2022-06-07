import 'package:app/models/model.dart';

/// We'll use this class to map between the fields of the Word class
/// and the corresponding columns names in the database table.
class WordFields {
  static final List<String> values = [
    // Add all fields
    id, theme, isUnderTheme, word, translation, definition, conjugation,
    declensions, examples, pronunciation
  ];

  // Each field is associated with its corresponding column name
  static const String id = '_id';
  static const String theme = 'theme';
  static const String isUnderTheme = 'isUnderTheme';
  static const String word = 'word';
  static const String translation = 'translation';
  static const String definition = 'definition';
  static const String conjugation = 'conjugation';
  static const String declensions = 'declensions';
  static const String examples = 'examples';
  static const String pronunciation = 'pronunciation';
}

/// Class that defines the structures for the dictionary words
class Word extends Model {
  // Name of the table in the database that will hold the Words model
  static String table = 'Words';

  final String theme;
  final String isUnderTheme;
  final String word;
  final String translation;
  final String definition;
  final String conjugation;
  final String declensions;
  final String examples;
  final String pronunciation;

  // Class constructor
  Word({
    int? id,
    required this.theme,
    required this.isUnderTheme,
    required this.word,
    required this.translation,
    required this.definition,
    required this.conjugation,
    required this.declensions,
    required this.examples,
    required this.pronunciation,
  }) : super(id);

  /// Create Word object using map ({String: object} dictionary)
  static Word fromMap(Map<String, dynamic> map) {
    return Word(
      id: map[WordFields.id] as int?,
      theme: map[WordFields.theme] as String,
      isUnderTheme: map[WordFields.isUnderTheme] as String,
      word: map[WordFields.word] as String,
      translation: map[WordFields.translation] as String,
      definition: map[WordFields.definition] as String,
      conjugation: map[WordFields.conjugation] as String,
      declensions: map[WordFields.declensions] as String,
      examples: map[WordFields.examples] as String,
      pronunciation: map[WordFields.pronunciation] as String
    );
  }

  static List<Word> fromList(List<Map<String, dynamic>> list) {
    return list.map((item) => Word(
        id: item[WordFields.id] as int?,
        theme: item[WordFields.theme] as String,
        isUnderTheme: item[WordFields.isUnderTheme] as String,
        word: item[WordFields.word] as String,
        translation: item[WordFields.translation] as String,
        definition: item[WordFields.definition] as String,
        conjugation: item[WordFields.conjugation] as String,
        declensions: item[WordFields.declensions] as String,
        examples: item[WordFields.examples] as String,
        pronunciation: item[WordFields.pronunciation] as String
    )).toList();
  }

  @override
  /// Create map ({String: object} dictionary) from a Word instance fields
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      WordFields.id: id,
      WordFields.theme: theme,
      WordFields.isUnderTheme: isUnderTheme,
      WordFields.word: word,
      WordFields.translation: translation,
      WordFields.definition: definition,
      WordFields.conjugation: conjugation,
      WordFields.declensions: declensions,
      WordFields.examples: examples,
      WordFields.pronunciation: pronunciation
    };
    return map;
  }
}