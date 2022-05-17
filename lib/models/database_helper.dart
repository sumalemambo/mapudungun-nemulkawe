import 'dart:io';
import 'dart:typed_data';

import 'package:app/models/word_model.dart';
import 'package:flutter/services.dart';
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
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "database.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", "database.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
    // open the database

    return await openDatabase(path, readOnly: true);
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
    ${WordFields.pronunciation} $textType)
    ''');
  }

  Future<Word> create(Word word) async {
    final db = await instance.database;

    final id = await db.insert(Word.table, word.toJson());

    return word.copy(id: id);
  }

  Future<Word> readWord(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      Word.table,
      columns: WordFields.values,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Word.fromMap(maps.first);
    } else {
      throw Exception('ID NOT FOUND');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}