import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> createCategory(Category category);
  Future<void> deleteCategory(int id);
  Future<bool> canDeleteCategory(int id);
}