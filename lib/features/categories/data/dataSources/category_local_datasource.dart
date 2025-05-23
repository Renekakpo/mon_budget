import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> createCategory(CategoryModel category);
  Future<void> deleteCategory(int id);
  Future<bool> canDeleteCategory(int id);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final DatabaseHelper databaseHelper;

  CategoryLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'categories',
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return CategoryModel.fromMap(maps[i]);
    });
  }

  @override
  Future<CategoryModel> createCategory(CategoryModel category) async {
    final db = await databaseHelper.database;
    final id = await db.insert(
      'categories',
      category.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return CategoryModel(
      id: id,
      name: category.name,
      iconName: category.iconName,
      colorValue: category.colorValue,
      createdAt: category.createdAt,
    );
  }

  @override
  Future<void> deleteCategory(int id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> canDeleteCategory(int id) async {
    final db = await databaseHelper.database;
    final result = await db.query(
      'expenses',
      where: 'category_id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isEmpty;
  }
}