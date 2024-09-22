import 'package:flutter/material.dart';

class CustomMovieDescription extends StatelessWidget {
  const CustomMovieDescription({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview:',
            style: TextStyle(
              color: Colors.white,
              fontSize:
                  screenWidth > 500 ? screenWidth * 0.04 : screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              fontFamily: 'Emad',
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey,
              fontSize:
                  screenWidth > 500 ? screenWidth * 0.035 : screenWidth * 0.045,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Photos of the movie:',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize:
                  screenWidth > 500 ? screenWidth * 0.035 : screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              fontFamily: 'Emad',
            ),
          ),
        ],
      ),
    );
  }
}
