import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/cubit/pobularMoviesCubit/popular_movies_cubit.dart';
import 'package:flicko/presentation/views/movie_details_view.dart';
import 'package:flicko/presentation/views/view_all_popular_movies_view.dart';
import 'package:flicko/presentation/views/view_all_top_rated_movies_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicko/constants.dart';
import 'package:flicko/cubit/nowPlayingMoviesCubit/now_playing_cubit.dart';
import 'package:flicko/cubit/topRatedMoviesCubit/top_rated_movies_cubit.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:flicko/presentation/widgets/custom_carousel_slider.dart';
import 'package:flicko/presentation/widgets/custom_movie_builder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Movie> searchResults = [];
  bool isLoading = false;
  bool isSearching = false;
  final List<Movie> movie = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchMovies(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
        isLoading = true;
      });

      try {
        final results = await _apiService.searchMovies(query);
        setState(() {
          searchResults = results;
        });
      } catch (e) {
        print("Error occurred: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isSearching = false;
        searchResults = [];
        isLoading = false;
      });
    }
  }

  void onMovieTap(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => MovieDetailsCubit()..fetchMovieDetails(movie.id),
          child: MovieDetailsView(movieId: movie.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TopRatedMoviesCubit()..fetchTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) => NowPlayingMoviesCubit()..fetchNowPlayingMovies(),
        ),
        BlocProvider(
          create: (context) => PopularMoviesCubit()..fetchPopularMovies(),
        ),
      ],
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight > 900
                      ? screenHeight * 0.04
                      : screenHeight * 0.02,
                  top: screenHeight > 900
                      ? screenHeight * 0.04
                      : screenHeight * 0.04,
                  right: screenWidth > 800
                      ? screenWidth * 0.1
                      : screenWidth * 0.05,
                  left: screenWidth > 800
                      ? screenWidth * 0.1
                      : screenWidth * 0.05,
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: searchMovies,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: isSearching
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              searchController.clear();
                              searchMovies('');
                            },
                          )
                        : null,
                    hintText: 'Search movies...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white12,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
            ),
            isLoading
                ? SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kSecondaryColor,
                      ),
                    ),
                  )
                : isSearching && searchResults.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/search.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'No results found',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight > 800
                                        ? screenHeight * 0.025
                                        : screenHeight * 0.015,
                                    fontFamily: 'Emad',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            if (!isSearching) ...[
                              BlocBuilder<NowPlayingMoviesCubit,
                                  NowPlayingMoviesState>(
                                builder: (context, state) {
                                  if (state is NowPlayingMoviesLoading) {
                                    return SizedBox(
                                      height: screenHeight * 0.4,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is NowPlayingMoviesError) {
                                    return Center(
                                      child: Text(
                                          'Failed to fetch top-rated movies: ${state.message}'),
                                    );
                                  }
                                  if (state is NowPlayingMoviesLoaded) {
                                    return CustomCarouselSlider(
                                      movies: state.movies,
                                      onTap: (movieId) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  MovieDetailsCubit()
                                                    ..fetchMovieDetails(
                                                        movieId),
                                              child: MovieDetailsView(
                                                  movieId: movieId),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              BlocBuilder<TopRatedMoviesCubit,
                                  TopRatedMoviesState>(
                                builder: (context, state) {
                                  if (state is TopRatedMoviesLoading) {
                                    return SizedBox(
                                        height: screenHeight * 0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircularProgressIndicator(
                                              color: kSecondaryColor,
                                            ),
                                            CircularProgressIndicator(
                                              color: kSecondaryColor,
                                            ),
                                          ],
                                        ));
                                  }
                                  if (state is TopRatedMoviesError) {
                                    return Center(
                                      child: Text(
                                          'Failed to fetch now playing movies: ${state.message}'),
                                    );
                                  }
                                  if (state is TopRatedMoviesLoaded) {
                                    return CustomMovieViewBuilder(
                                      movies: state.movies,
                                      onTap: (movieId) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  MovieDetailsCubit()
                                                    ..fetchMovieDetails(
                                                        movieId),
                                              child: MovieDetailsView(
                                                  movieId: movieId),
                                            ),
                                          ),
                                        );
                                      },
                                      title: 'Top Rated',
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ViewAllTopRatedMoviesView(),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              BlocBuilder<PopularMoviesCubit,
                                  PopularMoviesState>(
                                builder: (context, state) {
                                  if (state is PopularMoviesLoading) {
                                    return SizedBox(
                                      height: screenHeight * 0.8,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is PopularMoviesError) {
                                    return Center(
                                      child: Text(
                                          'Failed to fetch popular movies: ${state.message}'),
                                    );
                                  }
                                  if (state is PopularMoviesLoaded) {
                                    return CustomMovieViewBuilder(
                                      movies: state.movies,
                                      onTap: (movieId) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  MovieDetailsCubit()
                                                    ..fetchMovieDetails(
                                                        movieId),
                                              child: MovieDetailsView(
                                                  movieId: movieId),
                                            ),
                                          ),
                                        );
                                      },
                                      title: 'Popular',
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ViewAllPopularMoviesView(),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                            if (isSearching)
                              ...searchResults.map(
                                (movie) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: screenHeight > 900
                                        ? screenHeight * 0.004
                                        : screenHeight * 0.005,
                                    right: screenWidth > 800
                                        ? screenWidth * 0.1
                                        : screenWidth * 0.03,
                                    left: screenWidth > 800
                                        ? screenWidth * 0.09
                                        : screenWidth * 0.02,
                                  ),
                                  child: ListTile(
                                    leading: movie.posterPath.isNotEmpty
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.003),
                                            child: CachedNetworkImage(
                                              height: screenHeight > 900
                                                  ? screenHeight * 0.5
                                                  : screenHeight * 0.08,
                                              width: screenWidth > 800
                                                  ? screenWidth * 0.1
                                                  : screenWidth * 0.08,
                                              imageUrl: movie.fullImageUrl(),
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: kSecondaryColor),
                                              ),
                                            ),
                                          )
                                        : null,
                                    title: Text(
                                      movie.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                                MovieDetailsCubit()
                                                  ..fetchMovieDetails(movie.id),
                                            child: MovieDetailsView(
                                                movieId: movie.id),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
