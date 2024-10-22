import 'package:flicko/constants.dart';
import 'package:flicko/presentation/views/view_all_recommended_movies.dart';
import 'package:flicko/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RecommendationView extends StatefulWidget {
  const RecommendationView({super.key, this.id1, this.id2, this.id3});

  static const String id = 'recommendationView';

  final int? id1, id2, id3;

  @override
  _RecommendationViewState createState() => _RecommendationViewState();
}

class _RecommendationViewState extends State<RecommendationView> {
  List<String> categories = [
    'Action',
    'Adventure',
    'Comedy',
    'Crime',
    'Drama',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Thriller',
    'Mystery',
    'Animation',
    'Historical',
    'War',
    'Documentary',
    'Musical',
    'Family',
    'Western',
  ];
  Map<String, int> categoryMap = {
    'Action': 28,
    'Adventure': 12,
    'Comedy': 35,
    'Crime': 80,
    'Drama': 18,
    'Horror': 27,
    'Romance': 10749,
    'Sci-Fi': 878,
    'Fantasy': 14,
    'Thriller': 53,
    'Mystery': 9648,
    'Animation': 16,
    'Historical': 36,
    'War': 10752,
    'Documentary': 99,
    'Musical': 10402,
    'Family': 10751,
    'Western': 37,
  };
  String? selectedCategory1;
  String? selectedCategory2;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const CustomAppBar(
          title1: 'Recomme',
          title2: 'ndation',
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First Dropdown
            DropdownButton<String>(
              dropdownColor: kPrimaryColor,
              value: selectedCategory1,
              hint: const Text('Select Category 1'),
              onChanged: (value) {
                setState(() {
                  selectedCategory1 = value;
                });
              },
              isExpanded: true,
              icon: const Icon(Icons.arrow_downward),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              dropdownColor: kPrimaryColor,
              value: selectedCategory2,
              hint: const Text('Select Category 2'),
              onChanged: (value) {
                setState(() {
                  selectedCategory2 = value;
                });
              },
              isExpanded: true,
              icon: const Icon(Icons.arrow_downward),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                if (selectedCategory1 != null && selectedCategory2 != null) {
                  int? categoryId1 = categoryMap[selectedCategory1!];
                  int? categoryId2 = categoryMap[selectedCategory2!];

                  if (categoryId1 != null && categoryId2 != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllRecommendedMovies(
                          categoryId1: categoryId1,
                          categoryId2: categoryId2,
                        ),
                      ),
                    );
                  } else {
                    // Handle error in case the mapping fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to map categories to IDs.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select 2 categories'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: kSecondaryColor,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5,
              ),
              child: Text(
                'Get Recommendations',
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 18 : 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
