import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/property.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'properties.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE properties(
        id TEXT PRIMARY KEY,
        title TEXT,
        imageUrl TEXT,
        price REAL,
        bedrooms INTEGER,
        location TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  // إضافة عقار جديد
  Future<int> insertProperty(Property property) async {
    final db = await database;
    return await db.insert(
      'properties',
      property.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // جلب جميع العقارات
  Future<List<Property>> getProperties() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('properties');
    return List.generate(maps.length, (i) {
      return Property.fromMap(maps[i]);
    });
  }

  // تحديث بيانات عقار
  Future<int> updateProperty(Property property) async {
    final db = await database;
    return await db.update(
      'properties',
      property.toMap(),
      where: 'id = ?',
      whereArgs: [property.id],
    );
  }

  // حذف عقار
  Future<int> deleteProperty(String id) async {
    final db = await database;
    return await db.delete(
      'properties',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
