import '../constants.dart';
import '../widgets/custom_category_builder.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  static const String id = 'categoriesView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: const CustomCategoryBuilder(),
    );
  }
}
