import 'custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMovieTitle extends StatefulWidget {
  const CustomMovieTitle({
    super.key,
    required this.movieTitle,
    required this.genre1,
    required this.genre2,
    required this.genre3,
    required this.rating,
  });

  final String movieTitle, genre1, genre2, genre3;
  final double rating;

  @override
  State<CustomMovieTitle> createState() => _CustomMovieTitleState();
}

class _CustomMovieTitleState extends State<CustomMovieTitle> {
  bool isWatchLater = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth > 768;

    double titleFontSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;
    double iconSize = isTablet ? screenWidth * 0.045 : screenWidth * 0.06;
    double ratingFontSize =
        isTablet ? screenWidth * 0.035 : screenWidth * 0.045;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth * 0.75,
                child: Text(
                  widget.movieTitle,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isWatchLater = !isWatchLater;
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidBookmark,
                  size: iconSize, // Responsive icon size
                  color: isWatchLater
                      ? const Color.fromARGB(255, 227, 166, 12)
                      : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
                size: iconSize, // Responsive star size
              ),
              const SizedBox(width: 5),
              Text(
                widget.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: ratingFontSize,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Wrap(
            spacing: screenWidth * 0.03,
            runSpacing: 8,
            children: [
              if (widget.genre1.isNotEmpty)
                CustomElevatedButton(
                  title: widget.genre1,
                ),
              if (widget.genre2.isNotEmpty)
                CustomElevatedButton(
                  title: widget.genre2,
                ),
              if (widget.genre3.isNotEmpty)
                CustomElevatedButton(
                  title: widget.genre3,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
