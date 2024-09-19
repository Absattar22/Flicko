import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroScreens extends StatelessWidget {
  const IntroScreens({
    super.key,
    required this.title,
    required this.description,
    required this.img,
  });

  final String title;
  final String description;
  final String img;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth * 0.8,
              child: SvgPicture.asset(
                img,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              title,
              style: TextStyle(
                fontSize: screenHeight * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 152, 145, 145),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
