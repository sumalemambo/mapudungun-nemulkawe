import 'package:app/models/model.dart';

class WordFields {
  static final List<String> values = [
    // Add all fields
    id, theme, isUnderTheme, word, translation, definition, conjugation,
    declensions, examples, pronunciation
  ];

  static final String id = '_id';
  static final String theme = 'theme';
  static final String isUnderTheme = 'isUnderTheme';
  static final String word = 'word';
  static final String translation = 'translation';
  static final String definition = 'definition';
  static final String conjugation = 'conjugation';
  static final String declensions = 'declensions';
  static final String examples = 'examples';
  static final String pronunciation = 'pronunciation';
}

class Word extends Model {
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

  Word copy({
    int? id,
    String? theme,
    String? isUnderTheme,
    String? word,
    String? translation,
    String? definition,
    String? conjugation,
    String? declensions,
    String? examples,
    String? pronunciation
  }) =>
      Word(
        id: id ?? this.id,
        theme: theme ?? this.theme,
        isUnderTheme: isUnderTheme ?? this.isUnderTheme,
        word: word ?? this.word,
        translation: translation ?? this.translation,
        definition: definition ?? this.definition,
        conjugation: conjugation ?? this.conjugation,
        declensions: declensions ?? this.declensions,
        examples: examples ?? this.examples,
        pronunciation: pronunciation ?? this.pronunciation
      );

  /// Create Word object using {String: Object} dictionary
  static Word fromMap(Map<String, Object?> json) {
    return Word(
      id: json[WordFields.id] as int?,
      theme: json[WordFields.theme] as String,
      isUnderTheme: json[WordFields.isUnderTheme] as String,
      word: json[WordFields.word] as String,
      translation: json[WordFields.translation] as String,
      definition: json[WordFields.definition] as String,
      conjugation: json[WordFields.conjugation] as String,
      declensions: json[WordFields.declensions] as String,
      examples: json[WordFields.examples] as String,
      pronunciation: json[WordFields.pronunciation] as String
    );
  }

  @override
  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
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