import 'custom_movie_attribute.dart';
import 'package:flutter/material.dart';

class MovieAttributeBuilder extends StatelessWidget {
  const MovieAttributeBuilder(
      {super.key,
      required this.language,
      required this.date,
      required this.duration,
      required this.rating});

  final String language, date, rating;
  final String duration;

  String formatDuration(String durationInMinutes) {
    int totalMinutes = int.tryParse(durationInMinutes) ?? 0;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '$minutes min';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.03,
        right: screenWidth * 0.03,
        bottom: screenHeight * 0.025,
        top: screenHeight * 0.010,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomMovieAttribute(
                title: 'Duration',
                value: formatDuration(duration),
              ),
              CustomMovieAttribute(title: 'Rating', value: '$rating/10'),
              CustomMovieAttribute(title: 'Release Date', value: date),
              CustomMovieAttribute(
                title: 'Language',
                value: language.toUpperCase(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
