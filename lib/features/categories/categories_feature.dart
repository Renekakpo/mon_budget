import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../core/database/database_helper.dart';
import 'data/datasources/category_local_datasource.dart';
import 'data/repositories/category_repository_impl.dart';
import 'domain/usecases/get_categories.dart';
import 'domain/usecases/create_category.dart';
import 'domain/usecases/delete_category.dart';
import 'presentation/viewmodel/categories_viewmodel.dart';

class CategoriesFeature {
  static Widget create({required Widget child}) {
    return MultiProvider(
      providers: [
        Provider<DatabaseHelper>(
          create: (_) => DatabaseHelper(),
        ),
        ProxyProvider<DatabaseHelper, CategoryLocalDataSource>(
          update: (_, databaseHelper, __) =>
              CategoryLocalDataSourceImpl(databaseHelper),
        ),
        ProxyProvider<CategoryLocalDataSource, CategoryRepositoryImpl>(
          update: (_, dataSource, __) => CategoryRepositoryImpl(dataSource),
        ),
        ProxyProvider<CategoryRepositoryImpl, GetCategories>(
          update: (_, repository, __) => GetCategories(repository),
        ),
        ProxyProvider<CategoryRepositoryImpl, CreateCategory>(
          update: (_, repository, __) => CreateCategory(repository),
        ),
        ProxyProvider<CategoryRepositoryImpl, DeleteCategory>(
          update: (_, repository, __) => DeleteCategory(repository),
        ),
        ChangeNotifierProxyProvider3<GetCategories, CreateCategory, DeleteCategory, CategoriesViewModel>(
          create: (context) => CategoriesViewModel(
            getCategories: context.read<GetCategories>(),
            createCategory: context.read<CreateCategory>(),
            deleteCategory: context.read<DeleteCategory>(),
          ),
          update: (_, getCategories, createCategory, deleteCategory, previous) =>
          previous ?? CategoriesViewModel(
            getCategories: getCategories,
            createCategory: createCategory,
            deleteCategory: deleteCategory,
          ),
        ),
      ],
      child: child,
    );
  }
}