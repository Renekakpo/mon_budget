import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/create_category.dart';
import '../../domain/usecases/delete_category.dart';

enum CategoriesState { initial, loading, loaded, error }

class CategoriesViewModel extends ChangeNotifier {
  final GetCategories _getCategories;
  final CreateCategory _createCategory;
  final DeleteCategory _deleteCategory;

  CategoriesViewModel({
    required GetCategories getCategories,
    required CreateCategory createCategory,
    required DeleteCategory deleteCategory,
  })  : _getCategories = getCategories,
        _createCategory = createCategory,
        _deleteCategory = deleteCategory {
    loadCategories();
  }

  CategoriesState _state = CategoriesState.initial;
  List<Category> _categories = [];
  String? _errorMessage;

  CategoriesState get state => _state;
  List<Category> get categories => _categories;
  String? get errorMessage => _errorMessage;

  Future<void> loadCategories() async {
    _setState(CategoriesState.loading);
    try {
      _categories = await _getCategories();
      _setState(CategoriesState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(CategoriesState.error);
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      final newCategory = await _createCategory(category);
      _categories.insert(0, newCategory);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _setState(CategoriesState.error);
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
      await _deleteCategory(id);
      _categories.removeWhere((category) => category.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    if (_state == CategoriesState.error) {
      _setState(CategoriesState.loaded);
    }
  }

  void _setState(CategoriesState newState) {
    _state = newState;
    notifyListeners();
  }
}