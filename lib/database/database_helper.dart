import 'dart:io';

import 'package:app/models/word_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:app/models/model.dart';

/// Helper class to handle database transactions
class DatabaseHelper {
  // Singleton class (unique instance)
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb('database.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
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

    return await openDatabase(path, readOnly: false);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';

    await db.execute('''
    CREATE TABLE ${Word.table} (
    ${WordFields.id} $idType,
    ${WordFields.theme} $textType,
    ${WordFields.isUnderTheme} $textType,
    ${WordFields.word} $textType,
    ${WordFields.translation} $textType,
    ${WordFields.definition} $textType,
    ${WordFields.conjugation} $textType,
    ${WordFields.declensions} $textType,
    ${WordFields.examples} $textType,
    ${WordFields.pronunciation} $textType)
    ''');

    await db.execute('''
    CREATE TABLE Favorites (
    ${WordFields.id} INTEGER PRIMARY KEY
    )
    ''');
  }

  static Future<void> insert(String table, dynamic obj) async {
    // Get [database] instance
    final db = await instance.database;
    // Check if [obj] implements toMap() method, Dart is strongly typed so
    // we can do this
    if (obj is Model) {
      // Transform [obj] to dictionary
      obj = obj.toMap();
    }
    // Insert [obj] into [table]
    await db.insert(
        table,
        obj,
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> selectAll(
      String table,
      ) async {

    // Get [database] instance
    final db = await instance.database;
    // Select all the rows in [table]
    List<Map<String, dynamic>> rows = await db.query(table);
    return rows;
  }

  static Future<List<Map<String, dynamic>>> selectById(
      String table,
      String columnId,
      List<int> ids
      ) async {

      // Get [database] instance
      final db = await instance.database;
      // Select all the rows in [table] where [columnId] is in [ids]
      var rows = db.query(
        table,
        // Handle variable length of [ids] list (id1, id2, ...)
        where: '$columnId IN (${List.filled(ids.length, '?').join(',')})',
        whereArgs: ids
      );
      return rows;
  }

  Future<Word> create(Word word) async {
    final db = await instance.database;

    final id = await db.insert(Word.table, word.toMap());
    return word.copy(id: id);
  }

  Future<int> count(String table) async {
    final db = await instance.database;

    final rows = await db.rawQuery('SELECT COUNT(*) FROM $table');
    final nrows = firstIntValue(rows);
    if (nrows != null) {
      return nrows;
    }
    return 0;
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