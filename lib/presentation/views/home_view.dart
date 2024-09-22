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
                    top: screenHeight * 0.05, left: 16, right: 16),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
            ),
            isLoading
                ? const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 24, 109, 169),
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
                                const Text(
                                  'No results found',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: kSecondaryColor,
                                        ),
                                      ],
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
                                        print(
                                            'movie id: $movieId'); // This should print the movie ID
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
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: CircularProgressIndicator(
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is TopRatedMoviesError) {
                                    return Center(
                                      child: Text(
                                          'Failed to fetch now playing movies: ${state.message}'),
                                    );
                                  }
                                  if (state is TopRatedMoviesLoaded) {
                                    return CustomMovieViewBuilder(
                                      onTap: () {
                                        print(
                                            'movie id: ${state.movies.first.id}');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  MovieDetailsCubit()
                                                    ..fetchMovieDetails(
                                                        state.movies.first.id),
                                              child: MovieDetailsView(
                                                  movieId:
                                                      state.movies.first.id),
                                            ),
                                          ),
                                        );
                                      },
                                      title: 'Top Rated',
                                      movies: state.movies,
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
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircularProgressIndicator(
                                          color: kSecondaryColor,
                                        ),
                                      ],
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  MovieDetailsCubit()
                                                    ..fetchMovieDetails(
                                                        state.movies.first.id),
                                              child: MovieDetailsView(
                                                  movieId:
                                                      state.movies.first.id),
                                            ),
                                          ),
                                        );
                                      },
                                      title: 'Popular',
                                      movies: state.movies,
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
                                (movie) => ListTile(
                                  leading: movie.posterPath.isNotEmpty
                                      ? Image.network(
                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}')
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
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
