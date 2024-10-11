import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicko/constants.dart';
import 'package:flicko/cubit/loadAllPopularMoviesCubit/load_all_popular_movies_cubit.dart';
import 'movie_details_view.dart'; // Import the details screen

class ViewAllPopularMoviesView extends StatefulWidget {
  const ViewAllPopularMoviesView({super.key});

  @override
  ViewAllPopularMoviesViewState createState() =>
      ViewAllPopularMoviesViewState();
}

class ViewAllPopularMoviesViewState extends State<ViewAllPopularMoviesView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.04;

    return BlocProvider(
      create: (context) => LoadAllPopularMoviesCubit()..fetchAllPopularMovies(),
      child: BlocBuilder<LoadAllPopularMoviesCubit, LoadAllPopularMoviesState>(
        builder: (context, state) {
          print('State: $state'); // Debugging statement
          if (state is LoadAllPopularMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
              ),
            );
          }

          if (state is LoadAllPopularMoviesLoaded ||
              state is LoadAllPopularMoviesPaginationLoading) {
            final movies = state is LoadAllPopularMoviesLoaded
                ? state.movies
                : (state as LoadAllPopularMoviesPaginationLoading).movies;

            if (movies.isEmpty) {
              return const Center(
                child: Text(
                  'No movies available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.extentAfter == 0) {
                  LoadAllPopularMoviesCubit cubit = BlocProvider.of(context);
                  cubit.fetchAllPopularMovies(fromPagination: true);
                }

                return false;
              },
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      scrolledUnderElevation: 0,
                      pinned: false,
                      floating: true,
                      snap: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.01,
                      flexibleSpace: const FlexibleSpaceBar(
                        centerTitle: true,
                        background: CustomAppBar(
                          title1: 'Popu',
                          title2: 'lar',
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.width * 0.03
                              : MediaQuery.of(context).size.width * 0.03,
                          vertical: MediaQuery.of(context).size.height > 900
                              ? MediaQuery.of(context).size.height * 0.02
                              : MediaQuery.of(context).size.height * 0.01),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              MediaQuery.of(context).size.width > 600
                                  ? 0.7
                                  : 0.65,
                          crossAxisSpacing:
                              MediaQuery.of(context).size.width > 600
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : MediaQuery.of(context).size.width * 0.02,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.width > 600
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : MediaQuery.of(context).size.width * 0.025,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == movies.length) {
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
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
                                                    color: Colors.amber,
                                                    size: 16),
                                                const SizedBox(width: 5),
                                                Text(
                                                  movie.rating
                                                      .toStringAsFixed(1),
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
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
                              (state is LoadAllPopularMoviesPaginationLoading
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

          if (state is LoadAllPopularMoviesError) {
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
