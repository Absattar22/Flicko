import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicko/cubit/RecommendMoviesCubit/recommend_movies_cubit_cubit.dart';
import 'package:flicko/presentation/widgets/custom_app_bar.dart';
import 'package:flicko/constants.dart';
import 'movie_details_view.dart';

class ViewAllRecommendedMovies extends StatefulWidget {
  const ViewAllRecommendedMovies({
    super.key,
    required this.categoryId1,
    required this.categoryId2,
  });

  final int categoryId1, categoryId2;

  @override
  ViewAllRecommendedMoviesState createState() =>
      ViewAllRecommendedMoviesState();
}

class ViewAllRecommendedMoviesState extends State<ViewAllRecommendedMovies> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => RecommendMoviesCubit()
        ..fetchRecommendMovies(widget.categoryId1, widget.categoryId2),
      child: BlocBuilder<RecommendMoviesCubit, RecommendMoviesCubitState>(
        builder: (context, state) {
          if (state is RecommendMoviesCubitLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
              ),
            );
          }

          if (state is RecommendMoviesCubitLoaded ||
              state is RecommendMoviesCubitPaginationLoading) {
            final movies = state is RecommendMoviesCubitLoaded
                ? state.movies
                : (state as RecommendMoviesCubitPaginationLoading).movies;

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.extentAfter == 0) {
                  RecommendMoviesCubit cubit = BlocProvider.of(context);
                  cubit.fetchRecommendMovies(
                      widget.categoryId1, widget.categoryId2,
                      fromPagination: true);
                }
                return false;
              },
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      scrolledUnderElevation: 0,
                      pinned: false,
                      floating: true,
                      snap: true,
                      expandedHeight: screenHeight * 0.01,
                      flexibleSpace: const FlexibleSpaceBar(
                        centerTitle: true,
                        background: CustomAppBar(
                          title1: 'Recommended ',
                          title2: 'Movies',
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.01),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth > 600 ? 3 : 2,
                          childAspectRatio: screenWidth > 600 ? 0.7 : 0.65,
                          crossAxisSpacing: screenWidth * 0.03,
                          mainAxisSpacing: screenHeight * 0.02,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index >= movies.length &&
                                state
                                    is RecommendMoviesCubitPaginationLoading) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: kSecondaryColor,
                                  ),
                                ],
                              );
                            }

                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => MovieDetailsCubit()
                                        ..fetchMovieDetails(movie.id),
                                      child:
                                          MovieDetailsView(movieId: movie.id),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 126, 125, 125),
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                                        bottom: 5,
                                        left: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movie.title,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth * 0.04,
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
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  movie.rating
                                                      .toStringAsFixed(1),
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize:
                                                        screenWidth * 0.03,
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
                          childCount: movies.length +
                              (state is RecommendMoviesCubitPaginationLoading
                                  ? 1
                                  : 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is RecommendMoviesCubitError) {
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
