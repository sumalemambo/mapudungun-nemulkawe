import 'package:app/models/word_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';

    await db.execute('''
    CREATE TABLE $tableWords (
    ${WordFields.id} $idType,
    ${WordFields.theme} $textType,
    ${WordFields.isUnderTheme} $textType,
    ${WordFields.word} $textType,
    ${WordFields.translation} $textType,
    ${WordFields.image} $textType,
    ${WordFields.definition} $textType,
    ${WordFields.conjugation} $textType,
    ${WordFields.declensions} $textType,
    ${WordFields.examples} $textType,
    ${WordFields.pronunciation} $textType,
    ${WordFields.old} $textType)
    ''');
  }

  Future<Word> create(Word word) async {
    final db = await instance.database;

    final id = await db.insert(tableWords, word.toJson());

    return word.copy(id: id);
  }

  Future<Word> readWord(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableWords,
      columns: WordFields.values,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Word.fromJson(maps.first);
    } else {
      throw Exception('ID NOT FOUND');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}