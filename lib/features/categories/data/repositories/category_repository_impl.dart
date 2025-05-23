import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final categoryModels = await localDataSource.getCategories();
    return categoryModels.cast<Category>();
  }

  @override
  Future<Category> createCategory(Category category) async {
    final categoryModel = CategoryModel.fromEntity(category);
    final result = await localDataSource.createCategory(categoryModel);
    return result as Category;
  }

  @override
  Future<void> deleteCategory(int id) async {
    await localDataSource.deleteCategory(id);
  }

  @override
  Future<bool> canDeleteCategory(int id) async {
    return await localDataSource.canDeleteCategory(id);
  }
}