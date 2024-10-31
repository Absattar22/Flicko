import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class OtherSignInOptions extends StatelessWidget {
  const OtherSignInOptions({
    super.key,
    required this.text,
    this.onTap,
    required this.txtColor,
    required this.borderColor,
    required this.img,
    this.isGoogleLoading = false,
  });

  final VoidCallback? onTap;
  final String text;
  final Color txtColor;
  final Color borderColor;
  final String img;
  final bool isGoogleLoading;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: isGoogleLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.06,
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: const Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: isGoogleLoading
                  ? SizedBox(
                      height: screenHeight * 0.05,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kSecondaryColor),
                        strokeWidth: 3,
                      ),
                    )
                  : Image.asset(
                      img,
                      width: screenWidth * 0.08,
                      height: screenHeight * 0.04,
                    ),
            ),
            SizedBox(width: screenWidth * 0.02),
            isGoogleLoading
                ? Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Emad',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
