import 'package:flutter/material.dart';

import 'features/categories/categories_feature.dart';
import 'features/categories/presentation/view/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: CategoriesFeature.create(
        child: const CategoriesScreen(),
      ),
    );
  }
}
