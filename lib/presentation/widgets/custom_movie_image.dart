import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class CustomMovieImage extends StatelessWidget {
  final String img;

  const CustomMovieImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.35,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                8.0), // Optional: if you want rounded corners
            child: CachedNetworkImage(
              height: screenHeight * 0.35,
              width: double.infinity,
              imageUrl: img,
              fit: BoxFit
                  .cover, // Use BoxFit.cover to ensure the image covers the entire box
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
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
      ],
    );
  }
}
