import 'custom_movie_attribute.dart';
import 'package:flutter/material.dart';

class MovieAttributeBuilder extends StatelessWidget {
  const MovieAttributeBuilder(
      {super.key,
      required this.language,
      required this.date,
      required this.duration});

  final String language, date;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomMovieAttribute(title: 'Duration', value: '$duration min'),
              const SizedBox(width: 40),
              CustomMovieAttribute(title: 'Language', value: language),
              const SizedBox(width: 40),
              const CustomMovieAttribute(title: 'Rating', value: 'PG-13'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CustomMovieAttribute(title: 'Release Date', value: date),
              const SizedBox(width: 40),
              const CustomMovieAttribute(
                  title: 'Director', value: 'Christopher Nolan'),
            ],
          ),
        ],
      ),
    );
  }
}
