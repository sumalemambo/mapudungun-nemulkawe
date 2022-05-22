import 'package:app/models/model.dart';

/// Class that helps us map between the Word parameters and the
/// database columns
class WordFields {
  static final List<String> values = [
    // Add all fields
    id, theme, isUnderTheme, word, translation, definition, conjugation,
    declensions, examples, pronunciation
  ];

  // Database columns mapping
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

/// App model for words
class Word extends Model {
  static const String table = 'Words';

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

  /// Create Word object using map ({String: Object} dictionary)
  static Word fromMap(Map<String, Object?> map) {
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

  @override
  /// Transform a Word instance into a map object ({String: Object} dictionary)
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