import '../../constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key , required this.title1 , required this.title2});

  final String title1 , title2;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Text.rich(
        TextSpan(
          text: title1,
          style: TextStyle(
            fontSize: screenHeight * 0.022,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: title2,
              style: TextStyle(
                fontSize: screenHeight * 0.022,
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
