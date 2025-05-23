import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/category.dart';
import '../viewmodel/categories_viewmodel.dart';
import '../widgets/category_icon_selector.dart';
import '../widgets/category_color_selector.dart';

class AddCategoryScreen extends StatefulWidget {
  final CategoriesViewModel viewModel;

  const AddCategoryScreen({
    super.key,
    required this.viewModel
  });

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedIcon = 'category';
  Color _selectedColor = Colors.blue;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle catégorie'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Preview de la catégorie
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: _selectedColor,
                            child: Icon(
                              _getIconData(_selectedIcon),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _nameController.text.isEmpty
                                  ? 'Nom de la catégorie'
                                  : _nameController.text,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Champ nom
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom de la catégorie',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.label),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Veuillez saisir un nom pour la catégorie';
                      }
                      if (value.trim().length < 2) {
                        return 'Le nom doit contenir au moins 2 caractères';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 24),

                  // Sélecteur d'icône
                  Text(
                    'Icône',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  CategoryIconSelector(
                    selectedIcon: _selectedIcon,
                    onIconSelected: (icon) => setState(() => _selectedIcon = icon),
                  ),
                  const SizedBox(height: 24),

                  // Sélecteur de couleur
                  Text(
                    'Couleur',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  CategoryColorSelector(
                    selectedColor: _selectedColor,
                    onColorSelected: (color) =>
                        setState(() => _selectedColor = color),
                  ),
                  const SizedBox(height: 32),

                  // Bouton de sauvegarde
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveCategory,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Créer la catégorie'),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'restaurant':
        return Icons.restaurant;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'home':
        return Icons.home;
      case 'directions_car':
        return Icons.directions_car;
      case 'movie':
        return Icons.movie;
      case 'favorite':
        return Icons.favorite;
      case 'work':
        return Icons.work;
      case 'school':
        return Icons.school;
      case 'sports_soccer':
        return Icons.sports_soccer;
      case 'pets':
        return Icons.pets;
      default:
        return Icons.category;
    }
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final category = Category(
        name: _nameController.text.trim(),
        iconName: _selectedIcon,
        colorValue: _selectedColor.value,
        createdAt: DateTime.now(),
      );

      await widget.viewModel.addCategory(category);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Catégorie créée avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la création: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
