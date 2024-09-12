import 'package:flicko/constants.dart';
import 'package:flicko/widgets/custom_movie_cast.dart';
import 'package:flicko/widgets/custom_movie_description.dart';
import 'package:flicko/widgets/custom_movie_image.dart';
import 'package:flicko/widgets/custom_movie_title.dart';
import 'package:flicko/widgets/movie_attribute_builder.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});
  static const String id = 'movieDetails';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomMovieImage(screenHeight: screenHeight),
            const SizedBox(height: 20),
            const CustomMovieTitle(),
            const MovieAttributeBuilder(),
            const CustomMovieDescription(),
            const CustomMovieCast(),
          ],
        ),
      ),
    );
  }
}
