import 'package:flicko/constants.dart';
import 'package:flicko/widgets/custom_log_out.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Text.rich(
        TextSpan(
          text: 'Fli',
          style: TextStyle(
            fontSize: screenHeight * 0.022,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: 'cko',
              style: TextStyle(
                fontSize: screenHeight * 0.022,
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: const [
        CustomLogOut(),
      ],
    );
  }
}
