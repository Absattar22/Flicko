import 'package:flicko/constants.dart';

import '../widgets/custom_movie_cast.dart';
import '../widgets/custom_movie_description.dart';
import '../widgets/custom_movie_image.dart';
import '../widgets/custom_movie_title.dart';
import '../widgets/movie_attribute_builder.dart';
import 'package:flutter/material.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});
  static const String id = 'movieDetailsView';

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
