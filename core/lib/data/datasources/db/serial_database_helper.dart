import 'dart:async';

import 'package:core/data/models/serial_table.dart';
import 'package:sqflite/sqflite.dart';

class SerialDatabaseHelper {
  static SerialDatabaseHelper? _serialDatabaseHelper;
  SerialDatabaseHelper._instance() {
    _serialDatabaseHelper = this;
  }

  factory SerialDatabaseHelper() =>
      _serialDatabaseHelper ?? SerialDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'serial_watchlist';
  static const String _tblCache = 'serial_cache';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_serial.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<void> insertSerialCacheTransaction(
      List<SerialTable> serials, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final serial in serials) {
        final serialJson = serial.toMap();
        serialJson['category'] = category;
        txn.insert(_tblCache, serialJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheSerials(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearSerialCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertSerialWatchlist(SerialTable serial) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, serial.toMap());
  }

  Future<int> removeSerialWatchlist(SerialTable serial) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [serial.id],
    );
  }

  Future<Map<String, dynamic>?> getSerialById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistSerials() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
