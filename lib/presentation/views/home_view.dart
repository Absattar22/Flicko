import 'dart:math';

import 'package:flicko/constants.dart';
import 'package:flicko/cubit/movie_cubit.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:flicko/presentation/widgets/custom_carousel_slider.dart';
import 'package:flicko/presentation/widgets/custom_movie_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'categories_view.dart';
import 'movie_details_view.dart';


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
  List<Movie> movies = [];

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
        print(e);
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
    Navigator.pushNamed(
      context,
      MovieDetailsView.id,
      arguments: movie,
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieCubit>(context).fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 24, 109, 169),
              ),
            ),
          );
        } else if (state is MovieError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else {
          movies = (state as MovieLoaded).movies;
          return Scaffold(
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
                                icon: const Icon(Icons.clear,
                                    color: Colors.white),
                                onPressed: () {
                                  searchController.clear();
                                  searchMovies('');
                                },
                              )
                            : null,
                        hintText: 'Search movies...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white12,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
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
                                          MediaQuery.of(context).size.height /
                                              4,
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
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, CategoriesView.id),
                                    child: const CustomCarouselSlider(),
                                  ),
                                   CustomMovieViewBuilder(
                                    title: 'Top Rated',
                                    img: movies[Random().nextInt(movies.length)].posterPath,
                                    movieTitle: movies[Random().nextInt(movies.length)].title,
                                  ),
                                  const SizedBox(height: 10),
                                  const CustomMovieViewBuilder(
                                    title: 'Most Watched',
                                    img: 'assets/images/furious7.jpg',
                                    movieTitle: 'Furious 7',
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
                                      onTap: () => onMovieTap(movie),
                                    ),
                                  ),
                              ],
                            ),
                          ),
              ],
            ),
          );
        }
      },
    );
  }
}
