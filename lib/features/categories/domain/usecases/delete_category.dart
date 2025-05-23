import '../repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository repository;

  DeleteCategory(this.repository);

  Future<void> call(int id) async {
    final canDelete = await repository.canDeleteCategory(id);
    if (!canDelete) {
      throw Exception('Cannot delete category: it has associated expenses');
    }
    await repository.deleteCategory(id);
  }
}