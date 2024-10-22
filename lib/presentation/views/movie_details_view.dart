import 'package:flicko/cubit/AddToWatchListCubit/add_to_watch_list_cubit_cubit.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/presentation/widgets/custom_movie_recommendation.dart';
import 'package:flicko/presentation/widgets/custom_movie_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/constants.dart';
import 'package:flicko/presentation/widgets/custom_movie_image.dart';
import 'package:flicko/presentation/widgets/custom_movie_description.dart';
import 'package:flicko/presentation/widgets/movie_attribute_builder.dart';
import 'package:flicko/presentation/widgets/custom_movie_photos.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieId;
  final List<int>? movieIds;

  static const String id = 'movieDetailsView';
  const MovieDetailsView({super.key, required this.movieId, this.movieIds});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AddToWatchListCubit(apiService: ApiService()),
      child: Scaffold(
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              );
            } else if (state is MovieDetailsLoaded) {
              final movie = state.movie;
              final backdrops = state.backdrop;
              final similarMovies = state.similarMovies;

              return Scaffold(
                backgroundColor: kPrimaryColor,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomMovieImage(
                        img: movie.fullImageUrl(),
                      ),
                      CustomMovieTitle(
                        movieId: movie.id,
                        movieTitle: movie.title,
                        rating: double.parse(movie.rating.toStringAsFixed(1)),
                        genre1: movie.genres.isNotEmpty ? movie.genres[0] : '',
                        genre2: movie.genres.length > 1 ? movie.genres[1] : '',
                        genre3: movie.genres.length > 2 &&
                                movie.genres[2].isNotEmpty
                            ? movie.genres[2]
                            : 'Unknown',
                      ),
                      MovieAttributeBuilder(
                        language: movie.language,
                        date: movie.releaseDate,
                        duration: movie.duration.toString(),
                        rating: movie.rating.toStringAsFixed(1),
                      ),
                      CustomMovieDescription(
                        description: movie.overview,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      CustomMoviePhotos(
                        imageUrls: backdrops.length > 6
                            ? backdrops
                                .skip(24)
                                .take(12)
                                .map((backdrop) => backdrop.fullImageUrl())
                                .toList()
                            : backdrops
                                .take(6)
                                .map((backdrop) => backdrop.fullImageUrl())
                                .toList(),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: Text(
                          'You May Also Like:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth > 500
                                ? screenWidth * 0.04
                                : screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Emad',
                          ),
                        ),
                      ),
                      CustomMovieRecommendation(
                          recommendedMovies: similarMovies)
                    ],
                  ),
                ),
              );
            } else if (state is MovieDetailsError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }
            return const Center(
              child: Text(
                'No details available',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
