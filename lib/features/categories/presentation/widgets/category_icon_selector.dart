import 'package:flutter/material.dart';

class CategoryIconSelector extends StatelessWidget {
  final String selectedIcon;
  final Function(String) onIconSelected;

  const CategoryIconSelector({
    super.key,
    required this.selectedIcon,
    required this.onIconSelected,
  });

  static const List<Map<String, dynamic>> _icons = [
    {'name': 'restaurant', 'icon': Icons.restaurant, 'label': 'Alimentation'},
    {'name': 'shopping_bag', 'icon': Icons.shopping_bag, 'label': 'Shopping'},
    {'name': 'home', 'icon': Icons.home, 'label': 'Logement'},
    {'name': 'directions_car', 'icon': Icons.directions_car, 'label': 'Transport'},
    {'name': 'movie', 'icon': Icons.movie, 'label': 'Divertissement'},
    {'name': 'favorite', 'icon': Icons.favorite, 'label': 'Santé'},
    {'name': 'work', 'icon': Icons.work, 'label': 'Travail'},
    {'name': 'school', 'icon': Icons.school, 'label': 'Éducation'},
    {'name': 'sports_soccer', 'icon': Icons.sports_soccer, 'label': 'Sport'},
    {'name': 'pets', 'icon': Icons.pets, 'label': 'Animaux'},
    {'name': 'category', 'icon': Icons.category, 'label': 'Général'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          final iconData = _icons[index];
          final isSelected = selectedIcon == iconData['name'];

          return GestureDetector(
            onTap: () => onIconSelected(iconData['name']),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: Icon(
                iconData['icon'],
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade600,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}