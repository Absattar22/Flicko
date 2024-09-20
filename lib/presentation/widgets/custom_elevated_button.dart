import '../../constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: kSecondaryColor,
        textStyle: TextStyle(
          fontSize: screenWidth > 400 ? 14 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
