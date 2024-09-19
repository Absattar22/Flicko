import 'custom_movie_attribute.dart';
import 'package:flutter/material.dart';

class MovieAttributeBuilder extends StatelessWidget {
  const MovieAttributeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomMovieAttribute(title: 'Duration', value: '2h 49m'),
              SizedBox(width: 40),
              CustomMovieAttribute(title: 'Language', value: 'English'),
              SizedBox(width: 40),
              CustomMovieAttribute(title: 'Rating', value: 'PG-13'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              CustomMovieAttribute(title: 'Release Date', value: '2014'),
              SizedBox(width: 40),
              CustomMovieAttribute(
                  title: 'Director', value: 'Christopher Nolan'),
            ],
          ),
        ],
      ),
    );
  }
}
