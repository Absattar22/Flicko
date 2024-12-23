import 'package:flicko/constants.dart';
import 'package:flicko/cubit/AddToWatchListCubit/add_to_watch_list_cubit_cubit.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/presentation/views/tmdb_web_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // To store session
import 'custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMovieTitle extends StatefulWidget {
  const CustomMovieTitle({
    super.key,
    required this.movieTitle,
    required this.movieId,
    required this.genre1,
    required this.genre2,
    required this.genre3,
    required this.rating,
  });

  final String movieTitle, genre1, genre2, genre3;
  final double rating;
  final int movieId;

  @override
  State<CustomMovieTitle> createState() => _CustomMovieTitleState();
}

class _CustomMovieTitleState extends State<CustomMovieTitle> {
  bool isWatchLater = false;
  bool isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _checkIfInWatchlist();
  }

  Future<void> _checkIfInWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('sessionId');

    if (sessionId != null) {
      dynamic accountId = await ApiService().getAccountDetails(sessionId) ?? 0;

      final watchlist = await _apiService.getWatchlist(sessionId, accountId);
      if (watchlist != null) {
        setState(() {
          isWatchLater =
              watchlist.any((movie) => movie['id'] == widget.movieId);
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  // Method to handle adding/removing movie from watchlist
  Future<void> _handleWatchlistAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('sessionId');

    if (sessionId == null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginWebView(
            onLoginSuccess: (sessionId) async {
              await prefs.setString('sessionId', sessionId);
              _addToWatchlist(sessionId);
            },
          ),
        ),
      );
    } else {
      if (isWatchLater) {
        await _removeFromWatchlist(sessionId);
      } else {
        // Session exists, add to watchlist
        _addToWatchlist(sessionId);
      }
    }
  }

  Future<void> _addToWatchlist(String sessionId) async {
    dynamic accountId = await _apiService.getAccountDetails(sessionId);
    print('$accountId  , ${widget.movieId} , $sessionId , $isWatchLater');
    final successAddedMovie = await _apiService.updateWatchlist(
      sessionId,
      accountId,
      widget.movieId,
      true,
    );

    if (successAddedMovie) {
      setState(() {
        isWatchLater = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text('${widget.movieTitle} added to watchlist!')),
      );
    } else {
      setState(() {
        isWatchLater = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text('Failed to add ${widget.movieTitle} to watchlist!')),
      );
    }
  }

  Future<void> _removeFromWatchlist(String sessionId) async {
    dynamic accountId = await _apiService.getAccountDetails(sessionId);
    final successDeletedMovies = await _apiService.updateWatchlist(
      sessionId,
      accountId,
      widget.movieId,
      false,
    );

    if (successDeletedMovies == false) {
      setState(() {
        isWatchLater = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text('${widget.movieTitle} is removed from watchlist!')),
      );
    }
    print('successDeletedMovies: $successDeletedMovies');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth > 768;

    double titleFontSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;
    double iconSize = isTablet ? screenWidth * 0.045 : screenWidth * 0.06;
    double ratingFontSize =
        isTablet ? screenWidth * 0.035 : screenWidth * 0.045;

    return isLoading
        ? Padding(
            padding: EdgeInsets.only(
                right: screenWidth * 0.03, top: screenHeight * 0.015),
            child: Align(
              alignment: Alignment.topRight,
              child: CircularProgressIndicator(
                color: kSecondaryColor,
                strokeWidth: 2,
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenHeight * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: Text(
                        widget.movieTitle,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _handleWatchlistAction();
                        return BlocProvider.of<AddToWatchListCubit>(context)
                            .fetchWatchlist();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.solidBookmark,
                        size: iconSize,
                        color: isWatchLater
                            ? const Color.fromARGB(255, 227, 166, 12)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: iconSize,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: ratingFontSize,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.03),
                Wrap(
                  spacing: screenWidth * 0.03,
                  runSpacing: 8,
                  children: [
                    if (widget.genre1.isNotEmpty)
                      CustomElevatedButton(
                        title: widget.genre1,
                      ),
                    if (widget.genre2.isNotEmpty)
                      CustomElevatedButton(
                        title: widget.genre2,
                      ),
                    if (widget.genre3.isNotEmpty)
                      CustomElevatedButton(
                        title: widget.genre3,
                      ),
                  ],
                ),
              ],
            ),
          );
  }
}
