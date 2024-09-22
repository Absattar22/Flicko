import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class CustomMovieImage extends StatelessWidget {
  final String img;

  const CustomMovieImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10.0,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
              fadeOutCurve: Curves.easeIn,
              fadeInCurve: Curves.easeInOutCirc,
              imageUrl: img,
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        // Positioned back button
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
