import 'package:flicko/constants.dart';
import 'package:flicko/presentation/views/view_all_category_movies.dart';
import '../widgets/custom_category_builder.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  static const String id = 'categoriesView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: CustomCategoryBuilder(
        onTap: (categoryId, title) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewAllCategoryMovies(
                title: title,
                categoryId: categoryId,
              ),
            ),
          );
        },
      ),
    );
  }
}
