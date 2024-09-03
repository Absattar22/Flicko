import 'package:flutter/material.dart';

class CustomMovieImage extends StatelessWidget {
  final double screenHeight;

  const CustomMovieImage({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.30,
          width: double.infinity,
          child: Image.asset(
            'assets/images/Interstellar2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const Positioned(
          right: 20,
          top: 20,
          child: Icon(Icons.favorite_border, color: Colors.white),
        ),
      ],
    );
  }
}
