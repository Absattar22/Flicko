import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/cubit/CategoryCubit/categories_cubit_cubit.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicko/constants.dart';
import 'movie_details_view.dart';

class ViewAllCategoryMovies extends StatefulWidget {
  const ViewAllCategoryMovies(
      {super.key, required this.title, required this.categoryId});

  final String title;
  final int categoryId;

  @override
  ViewAllCategoryMoviesState createState() => ViewAllCategoryMoviesState();
}

class ViewAllCategoryMoviesState extends State<ViewAllCategoryMovies> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.04;

    return BlocProvider(
      create: (context) =>
          CategoriesCubit()..fetchCategories(widget.categoryId),
      child: BlocBuilder<CategoriesCubit, CategoriesCubitState>(
        builder: (context, state) {
          if (state is CategoriesCubitLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
              ),
            );
          }
          if (state is CategoriesCubitLoaded ||
              state is CategoriesCubitPaginationLoading) {
            final movies = state is CategoriesCubitLoaded
                ? state.movies
                : (state as CategoriesCubitPaginationLoading).movies;
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent) {
                  CategoriesCubit cubit = BlocProvider.of(context);
                  cubit.fetchCategories(widget.categoryId,
                      fromPagination: true);
                }
                return true;
              },
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: CustomScrollView(slivers: [
                  SliverAppBar(
                    pinned: false,
                    floating: true,
                    snap: true,
                    expandedHeight: screenHeight * 0.01,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: CustomAppBar(
                        title1: '${widget.title} ',
                        title2: 'Movies',
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600
                            ? screenWidth * 0.03
                            : screenWidth * 0.03,
                        vertical: screenHeight > 900
                            ? screenHeight * 0.02
                            : screenHeight * 0.01),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: screenWidth > 600 ? 0.7 : 0.65,
                        crossAxisSpacing: screenWidth > 600
                            ? screenWidth * 0.03
                            : screenWidth * 0.02,
                        mainAxisSpacing: screenWidth > 600
                            ? screenWidth * 0.03
                            : screenWidth * 0.025,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index == movies.length) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  kSecondaryColor),
                            ),
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
                                  child: MovieDetailsView(movieId: movie.id),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color.fromARGB(255, 126, 125, 125),
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
                          childCount: movies.length +
                              (state is CategoriesCubitPaginationLoading
                                  ? 1
                                  : 0)),
                    ),
                  ),
                ]),
              ),
            );
          }
          if (state is CategoriesCubitError) {
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
