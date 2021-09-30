import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbname = 'myDatabase.db';
  static final _dbversion = 1;
  static final _tableName = 'myTable';

  static final columnId = '_id';
  static final ColumnName = 'name';

  //asking it is a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
// define the database
  static Database? _database;

// get the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiatedatabase();
    return _database!;
  }

  //if databse null then initiate the database in the device

  _initiatedatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbname);
    return await openDatabase(path, version: _dbversion, onCreate: _onCreat);
  }

// create database table
  Future? _onCreat(Database db, int version) {
    db.execute('''
    CREATE TABLE $_tableName (
    $columnId INTEGER PRIMARY KEY,
    $ColumnName TEXT NOT NULL )
    
    ''');
  }

// database insert function
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

// databse quary method (if u can see the database values on this function call)
  Future<List<Map<String, dynamic>>> quaryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  // update the database

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

// delete the elemet in the database

  Future delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId= ?', whereArgs: [id]);
  }
}
