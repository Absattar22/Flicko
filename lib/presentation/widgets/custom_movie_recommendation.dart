import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:flicko/presentation/views/movie_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMovieRecommendation extends StatelessWidget {
  const CustomMovieRecommendation({
    super.key,
    required this.recommendedMovies,
  });

  final List<Movie> recommendedMovies;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight > 900 ? screenHeight * 0.4 : screenHeight * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendedMovies.length,
        itemBuilder: (context, index) {
          final movie = recommendedMovies[index];
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          MovieDetailsCubit()..fetchMovieDetails(movie.id),
                      child: MovieDetailsView(
                        movieId: movie.id,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width:
                    screenWidth > 500 ? screenWidth * 0.4 : screenWidth * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45.withOpacity(0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: movie.fullImageUrl(),
                        height: screenHeight * 0.25,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: kSecondaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth > 500
                              ? screenWidth * 0.02
                              : screenWidth * 0.04),
                      child: Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth > 500
                              ? screenWidth * 0.032
                              : screenWidth * 0.037,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                          fontFamily: 'Emad',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth > 500
                              ? screenWidth * 0.015
                              : screenWidth * 0.04),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber[400],
                            size: screenWidth > 500
                                ? screenWidth * 0.035
                                : screenWidth * 0.04,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: TextStyle(
                              color: const Color(0xFFA59F9F),
                              fontSize: screenWidth > 500
                                  ? screenWidth * 0.03
                                  : screenWidth * 0.035,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Emad',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
