import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/category.dart';
import '../viewmodel/categories_viewmodel.dart';
import '../widgets/category_list_item.dart';
import 'add_category_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<CategoriesViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case CategoriesState.initial:
            case CategoriesState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case CategoriesState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Une erreur est survenue',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.errorMessage ?? 'Erreur inconnue',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.clearError();
                        viewModel.loadCategories();
                      },
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              );

            case CategoriesState.loaded:
              if (viewModel.categories.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucune catégorie',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ajoutez votre première catégorie de dépense',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: viewModel.loadCategories,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = viewModel.categories[index];
                    return CategoryListItem(
                      category: category,
                      onDelete: () => _showDeleteDialog(context, category, viewModel),
                    );
                  },
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddCategory(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddCategory(BuildContext context) {
    final viewModel = Provider.of<CategoriesViewModel>(context, listen: false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCategoryScreen(
          viewModel: viewModel,
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context,
      Category category,
      CategoriesViewModel viewModel,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer la catégorie'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer la catégorie "${category.name}" ?\n\n'
                'Cette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final success = await viewModel.deleteCategory(category.id!);
                if (!success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Impossible de supprimer cette catégorie car elle est associée à des dépenses.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}