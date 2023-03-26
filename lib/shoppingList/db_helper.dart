import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'shopping_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> resetDatabase() async {
    print('DELETING DATABASE AND RESETTING');
    final db = await instance.database;
    await db.close();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'shopping_list.db');
    await deleteDatabase(path);
    _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'shopping_list.db');
    print('$path');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shopping_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        isBought INTEGER NOT NULL DEFAULT 0,
        timeBought TEXT
      )
    ''');
  }

  Future<List<ShoppingItem>> getItems() async {
    final db = await instance.database;
    var items = await db.query('shopping_items');
    List<ShoppingItem> shoppingList = items.isNotEmpty
        ? items.map((c) => ShoppingItem.fromMap(c)).toList()
        : [];
    return shoppingList;
  }

  Future<int> addItem(String name, int quantity) async {
    final db = await database;
    int id = await db.insert('shopping_items', {
      'name': name,
      'quantity': quantity,
      'isBought': 0,
      'timeBought': null,
    });
    print('$id, $name, $quantity');
    return id;
  }

  Future<void> editItem(int id, String newName, int newQuantity) async {
    final db = await database;
    await db.update(
      'shopping_items',
      {'name': newName, 'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('item: $id, $newName, $newQuantity; has been updated');
  }

  Future<void> removeItem(int id) async {
    final db = await database;
    await db.delete('shopping_items', where: 'id = ?', whereArgs: [id]);
    print('$id has been removed');
  }

  Future<void> buyItem(int id) async {
    final db = await database;
    await db.update(
      'shopping_items',
      {'isBought': 1, 'timeBought': DateTime.now().toString()},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('item $id has been marked as bought');
  }

  Future<void> unbuyItem(int id) async {
    final db = await database;
    await db.update(
      'shopping_items',
      {'isBought': 0, 'timeBought': null},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('item $id has been marked as unbought');
  }
}