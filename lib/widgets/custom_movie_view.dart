import 'package:flutter/material.dart';

class CustomMovieView extends StatelessWidget {
  const CustomMovieView({super.key, required this.img, required this.title});

  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          img,
          width: screenWidth > 700 ? screenWidth * 0.40 : screenWidth * 0.48,
          height:
              screenHeight > 900 ? screenHeight * 0.30 : screenHeight * 0.25,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.01, right: screenWidth > 700 ? 40 : 45),
          child: SizedBox(
            width: screenWidth * 0.4,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenHeight * 0.016,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow.shade700,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              '10',
              style: TextStyle(
                fontSize: screenHeight * 0.017,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 130, 128, 128),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
