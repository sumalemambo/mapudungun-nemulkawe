import 'dart:io';

import 'package:app/models/abstract_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:app/models/wordModel.dart';

/// Helper class to handle database transactions
class DatabaseHelper {
  // Singleton class (unique instance)
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  /// Method to init the [_database] field if its not already initialized and
  /// get the database connection
  ///
  /// This method will be called each time a method uses [instance.database], it
  /// will initialize the database connection if it has not been initialized
  /// before and will return the connection object.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  /// This method initializes the connection with the database, if a database
  /// doesn't exist already it will create copy from the database in the assets
  /// on and return a connection to it or just return a connection if there's
  /// already one.
  Future<Database> _initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'database.db');

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
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

    }

    // Open the database
    return await openDatabase(path, readOnly: false);
  }

  /// Method to insert [obj] on the [table] table in the database.
  static Future<void> insert(String table, dynamic obj) async {
    // Get [database] instance
    final db = await instance.database;
    // Check if [obj] implements toMap() method, Dart is strongly typed so
    // we can do this
    if (obj is AbstractModel) {
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

  /// Method to select all rows from [table] table
  static Future<List<Map<String, dynamic>>> selectAll(
      String table,
      ) async {

    // Get [database] instance
    final db = await instance.database;
    // Select all the rows in [table]
    List<Map<String, dynamic>> rows = await db.query(table);
    return rows;
  }

  static Future<void> delete(String table, int id) async {
    final db = await instance.database;
    db.delete(table, where: '_id=$id');
  }

  static Future<void> delete2(String table, String id) async {
    final db = await instance.database;
    db.delete(table, where: '_id=$id');
  }

  static Future<void> deleteWhere(String table,String where, String id) async {
    final db = await instance.database;
    db.delete(table, where: '$where=$id');
  }

  /// Method to select the rows in [table] where the id column [columnId] is in
  /// [ids] list
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

  static Future<List<Map<String, dynamic>>> selectById2(
      String table,
      String columnId,
      List<String> ids
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

  static Future<List<Map<String, dynamic>>> selectByIndex(
      String table,
      int index
      ) async {

    // Get [database] instance
    final db = await instance.database;
    // Select all the rows in [table] where [columnId] is in [ids]
    var rows = db.query(
        table,
        // Handle variable length of [ids] list (id1, id2, ...)
        where: 'ROWID = $index',
    );
    return rows;
  }

  /// Method to select rows from [table] in the range [offset, limit]
  static Future<List<Map<String, dynamic>>> fetchRange(
      String table,
      int offset,
      int limit
      ) async {

    // Get [database] instance
    final db = await instance.database;
    var rows = db.rawQuery(
      '''
      SELECT * FROM $table WHERE ROWID IN (
        SELECT ROWID FROM $table LIMIT ? OFFSET ?
      )
      ''',
      // Arguments
      [limit, offset]
    );
    return rows;
  }

  /// Method to get the numbers of rows in the [table] table
  static Future<int> count(String table) async {
    // Get [database] instance
    final db = await instance.database;

    // Get the number of rows on [table]
    final rows = await db.rawQuery('SELECT COUNT(*) FROM $table');
    final nrows = firstIntValue(rows);
    if (nrows != null) {
      return nrows;
    }
    return 0;
  }

  static Future<int> createDB() async {
    final db = await instance.database;

    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';

    await db.execute('''
    CREATE TABLE ${WordModel.table} (
    ${WordModelFields.id} $idType,
    ${WordModelFields.mapudungun} $textType,
    ${WordModelFields.gramatica} $textType,
    ${WordModelFields.castellano} $textType,
    ${WordModelFields.ejemplo} $textType)
    ''');

    return 1;
  }

  static Future <void> deleteTable(String tableName) async {
    final db = await instance.database;

    await db.delete(tableName);
  }

  static Future <void> dropTable(String tableName) async {
    final db = await instance.database;

    await db.execute('DROP TABLE IF EXISTS $tableName');
  }

  /// Method to close the database
  Future close() async {
    // Get [database] instance
    final db = await instance.database;

    db.close();
  }
}