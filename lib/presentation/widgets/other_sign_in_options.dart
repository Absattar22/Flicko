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
  final bool isGoogleLoading; // Loading state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isGoogleLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
              padding: const EdgeInsets.all(10.0),
              child: isGoogleLoading
                  ? SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kSecondaryColor),
                        strokeWidth: 3,
                      ),
                    )
                  : Image.asset(
                      img,
                      width: 30,
                      height: 30,
                    ),
            ),
            const SizedBox(width: 10),
            isGoogleLoading
                ? const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Emad',
                      
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
