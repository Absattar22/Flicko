import 'package:flutter/material.dart';

class CustomMovieAttribute extends StatelessWidget {
  final String title;
  final String value;

  const CustomMovieAttribute(
      {required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize:
                screenWidth > 500 ? screenWidth * 0.03 : screenWidth * 0.045,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey,
            fontSize:
                screenWidth > 500 ? screenWidth * 0.025 : screenWidth * 0.035,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
