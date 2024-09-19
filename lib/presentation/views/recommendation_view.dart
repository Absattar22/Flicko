import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class RecommendationView extends StatefulWidget {
  const RecommendationView({super.key});

  static const String id = 'recommendationView';

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
  ];
  String? selectedCategory1;
  String? selectedCategory2;
  String? selectedCategory3;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Movie Recommendation'),
        backgroundColor: kPrimaryColor,
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

            DropdownButton<String>(
              value: selectedCategory3,
              hint: const Text('Select Category 3'),
              onChanged: (value) {
                setState(() {
                  selectedCategory3 = value;
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
            const SizedBox(height: 24),
        
            ElevatedButton(
              onPressed: () {
                if (selectedCategory1 != null && selectedCategory2 != null) {
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please select at least 2 categories',
                      ),
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
