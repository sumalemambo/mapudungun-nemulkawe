//Theme,Is Under The Theme,Word,Translation,Image,Definition,Conjugation,
// Declensions,Examples,Pronunciation,OLD

class Word {
  final int id;
  final String theme;
  final String word;
  final String translation;
  final String definition;


  const Word({
    required this.id,
    required this.theme,
    required this.word,
    required this.translation,
    required this.definition,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theme': theme,
      'word': word,
      'translation': translation,
      'definition': definition,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Word{id: $id, theme: $theme, word: $word,'
        ' translation: $translation, definition: $definition}';
  }
}