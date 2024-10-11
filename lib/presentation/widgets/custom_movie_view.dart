import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class CustomMovieView extends StatelessWidget {
  const CustomMovieView(
      {super.key,
      required this.img,
      required this.title,
      required this.rating});

  final String img, title, rating;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(255, 126, 125, 125),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: img,
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: kSecondaryColor,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: screenWidth > 700 ? screenWidth * 0.4 : screenWidth * 0.5,
              height:
                  screenHeight > 900 ? screenHeight * 0.4 : screenHeight * 0.31,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.01,
              right:
                  screenWidth > 700 ? screenWidth * 0.06 : screenWidth * 0.15),
          child: SizedBox(
            width: screenWidth * 0.4,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenHeight > 1000
                    ? screenHeight * 0.02
                    : screenHeight * 0.015,
                fontWeight: FontWeight.bold,
                fontFamily: 'Emad',
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow.shade700,
              size: 16,
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              rating,
              style: TextStyle(
                fontSize: screenHeight * 0.017,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 154, 151, 151),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
