import 'dart:async';
import 'package:flicko/constants.dart';
import 'package:flicko/cubit/AddToWatchListCubit/add_to_watch_list_cubit_cubit.dart';
import 'package:flicko/cubit/movieDetailsCubit/movie_details_cubit.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/presentation/views/movie_details_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class WatchListView extends StatefulWidget {
  const WatchListView({super.key});
  static const String id = 'watchListView';

  @override
  State<WatchListView> createState() => _WatchListViewState();
}

class _WatchListViewState extends State<WatchListView> {
  final ApiService _apiService = ApiService();
  List<dynamic> _watchlist = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => _loadWatchlist());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadWatchlist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('sessionId');
      if (sessionId != null) {
        int? accountId = await _apiService.getAccountDetails(sessionId);
        final watchlist =
            await _apiService.getWatchlist(sessionId, accountId ?? 0);
        if (watchlist != null) {
          setState(() {
            _watchlist = watchlist;
          });
        }
      }
    } catch (e) {
      print('Error loading watchlist: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToWatchListCubit, AddToWatchListCubitState>(
      listener: (context, state) {
        if (state is AddToWatchListCubitUpdated) {
          // Reload watchlist when state is updated (movie added/removed)
          _loadWatchlist();
        }
      },
      child: BlocProvider(
        create: (context) => AddToWatchListCubit(apiService: _apiService),
        child: BlocBuilder<AddToWatchListCubit, AddToWatchListCubitState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: kPrimaryColor,
              body: _watchlist.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/No.png',
                              height: 200,
                            ),
                            const Text(
                              'No movies in your watchlist',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'Emad',
                              ),
                            ),
                          ],
                        ))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of items per row
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio:
                                  0.7, // Adjust to fit movie posters
                            ),
                            itemCount: _watchlist.length,
                            itemBuilder: (context, index) {
                              final movie = _watchlist[index];
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to movie detail view when tapped and use Cubit
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => MovieDetailsCubit()
                                          ..fetchMovieDetails(movie['id']),
                                        child: MovieDetailsView(
                                          movieId: movie['id'],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: GridTile(
                                  header: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    color: Colors.black54,
                                    child: Text(
                                      movie['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  footer: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    color: Colors.black54,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          movie['vote_average'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}
