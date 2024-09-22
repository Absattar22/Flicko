import '../../constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth > 500 ? screenWidth * 0.2 : screenWidth * 0.25,
      height: screenHeight > 900 ? screenHeight * 0.04 : screenHeight * 0.035,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kSecondaryColor,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
