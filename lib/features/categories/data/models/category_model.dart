import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    super.id,
    required super.name,
    required super.iconName,
    required super.colorValue,
    required super.createdAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      iconName: map['icon_name'] ?? '',
      colorValue: map['color_value']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon_name': iconName,
      'color_value': colorValue,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      iconName: category.iconName,
      colorValue: category.colorValue,
      createdAt: category.createdAt,
    );
  }

  @override
  CategoryModel copyWith({
    int? id,
    String? name,
    String? iconName,
    int? colorValue,
    DateTime? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}