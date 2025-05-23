import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'mon_budget.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Table des catégories
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon_name TEXT NOT NULL,
        color_value INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Table des dépenses (pour vérifier les associations)
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        label TEXT NOT NULL,
        date TEXT NOT NULL,
        observation TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // Insérer des catégories par défaut
    await _insertDefaultCategories(db);
  }

  Future<void> _insertDefaultCategories(Database db) async {
    final categories = [
      {'name': 'Alimentation', 'icon_name': 'restaurant', 'color_value': 0xFF2196F3},
      {'name': 'Shopping', 'icon_name': 'shopping_bag', 'color_value': 0xFF9E9E9E},
      {'name': 'Logement', 'icon_name': 'home', 'color_value': 0xFF9C27B0},
      {'name': 'Transport', 'icon_name': 'directions_car', 'color_value': 0xFF4CAF50},
      {'name': 'Divertissement', 'icon_name': 'movie', 'color_value': 0xFF673AB7},
      {'name': 'Santé', 'icon_name': 'favorite', 'color_value': 0xFFE91E63},
    ];

    for (var category in categories) {
      await db.insert('categories', {
        ...category,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}