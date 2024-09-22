import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/cubit/loadAllTopRatedMoviesCubit/load_all_top_rated_movies_cubit.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicko/constants.dart';
import 'package:flicko/cubit/loadAllPopularMoviesCubit/load_all_popular_movies_cubit.dart';
import 'movie_details_view.dart'; // Import the details screen

class ViewAllTopRatedMoviesView extends StatefulWidget {
  const ViewAllTopRatedMoviesView({super.key});

  @override
  ViewAllTopRatedMoviesViewState createState() =>
      ViewAllTopRatedMoviesViewState();
}

class ViewAllTopRatedMoviesViewState extends State<ViewAllTopRatedMoviesView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.04;

    return BlocProvider(
      create: (context) => LoadAllTopRatedMoviesCubit()..fetchTopRatedMovies(),
      child: BlocBuilder<LoadAllTopRatedMoviesCubit, LoadAllTopRatedMoviesState>(
        builder: (context, state) {
          if (state is LoadAllTopRatedMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
              ),
            );
          }
          if (state is LoadAllTopRatedMoviesLoaded) {
            return Scaffold(
              backgroundColor: kPrimaryColor,
              body: CustomScrollView(slivers: [
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  snap: true,
                  expandedHeight: screenHeight * 0.01,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    background: CustomAppBar(
                      title1: 'Top',
                      title2: 'Rated',
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final movie = state.movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => MovieDetailsCubit()
                                    ..fetchMovieDetails(movie.id),
                                  child: MovieDetailsView(movieId: movie.id),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: movie.fullImageUrl(),
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error,
                                            color: Colors.red),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.8),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                offset: const Offset(0, 1),
                                                blurRadius: 3,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.amber, size: 16),
                                            const SizedBox(width: 5),
                                            Text(
                                              movie.rating.toStringAsFixed(1),
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: fontSize * 0.8,
                                              ),
                                            ),
                                          ],
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
                      childCount: state.movies.length,
                    ),
                  ),
                ),
              ]),
            );
          }
          if (state is LoadAllTopRatedMoviesError) {
            return Center(
              child: Text(
                'Failed to load movies: ${state.message}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text(
              'No movies available',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
