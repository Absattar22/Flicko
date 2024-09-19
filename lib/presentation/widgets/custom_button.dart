import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.onTap,
    required this.color1,
    required this.color2,
    required this.txtColor,
    required this.borderColor,
  });

  VoidCallback? onTap;
  final String text;
  final Color color1;
  final Color color2;
  final Color txtColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.06,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: txtColor,
              fontSize: screenHeight * 0.020,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
