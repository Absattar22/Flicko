import 'package:flicko/widgets/custom_carousel_slider.dart';
import 'package:flicko/widgets/custom_now_showing.dart';
import 'package:flutter/material.dart';
import '../data/api.dart';
import '../models/movie_model.dart';
import 'categories_view.dart';
import 'movie_details_view.dart';
import '../constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
        _isLoading = true;
      });

      try {
        final results = await _apiService.searchMovies(query);
        setState(() {
          _searchResults = results;
        });
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isSearching = false;
        _searchResults = [];
        _isLoading = false;
      });
    }
  }

  void _onMovieTap(Movie movie) {
    Navigator.pushNamed(
      context,
      MovieDetailsView.id,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.05, left: 16, right: 16),
              child: TextField(
                controller: _searchController,
                onChanged: _searchMovies,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
          _isLoading
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 24, 109, 169),
                    ),
                  ),
                )
              : _isSearching && _searchResults.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/search.png',
                                height: MediaQuery.of(context).size.height / 4,
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
                          if (!_isSearching) ...[
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, CategoriesView.id),
                              child: const CustomCarouselSlider(),
                            ),
                            const CustomMovieViewBuilder(
                              title: 'Top Rated',
                              img: 'assets/images/AllTheBrightPlaces.jpg',
                              movieTitle: 'All The Bright Places',
                            ),
                            const CustomMovieViewBuilder(
                              title: 'Must Watch',
                              img: 'assets/images/furious7.jpg',
                              movieTitle: 'Furious 7',
                            ),
                          ],
                          if (_isSearching)
                            ..._searchResults.map(
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
                                onTap: () => _onMovieTap(movie),
                              ),
                            ),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
