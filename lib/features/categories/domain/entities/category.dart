class Category {
  final int? id;
  final String name;
  final String iconName;
  final int colorValue;
  final DateTime createdAt;

  Category({
    this.id,
    required this.name,
    required this.iconName,
    required this.colorValue,
    required this.createdAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? iconName,
    int? colorValue,
    DateTime? createdAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.iconName == iconName &&
        other.colorValue == colorValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    iconName.hashCode ^
    colorValue.hashCode;
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, iconName: $iconName, colorValue: $colorValue)';
  }
}