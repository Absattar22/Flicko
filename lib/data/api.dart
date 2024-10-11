// api_service.dart
import 'dart:convert';
import 'package:flicko/models/images_model.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '';
  int pageNum = 1;

  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    final url =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies({int page = 1}) async {
    final url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Backdrop>> fetchMovieImages(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Backdrop> images = (data['backdrops'] as List)
          .map((image) => Backdrop.fromJson(image))
          .toList();
      return images;
    } else {
      throw Exception('Failed to load movie images');
    }
  }

  Future<List<Movie>> fetchSimilarMovies(int movieId, {int page = 1}) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load similar movies');
    }
  }

  Future<List<Movie>> fetchGnreMovies(dynamic genreId,
      {int page = 1, double minRating = 7.0}) async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      final filteredMovies =
          movies.where((movie) => movie.rating >= minRating).toList();
      return filteredMovies;
    } else {
      throw Exception('Failed to load genre movies');
    }
  }

  Future<List<Movie>> FetchRecomdationWithGenres(
    dynamic genreId1,
    int genreId2, {
    int page = 1,
    double minRating = 7.0,
  }) async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId1,$genreId2&page=$page';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();

      final filteredMovies =
          movies.where((movie) => movie.rating >= minRating).toList();
      return filteredMovies;
    } else {
      throw Exception('Failed to load genre movies');
    }
  }

  // Future<List<Movie>> fetchMoviesByCast(int castId) async {
  //   final url =
  //       'https://api.themoviedb.org/3/person/$castId/movie_credits?api_key=$apiKey';
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final List<Movie> movies = (data['cast'] as List)
  //         .map((movie) => Movie.fromJson(movie))
  //         .toList();
  //     return movies;
  //   } else {
  //     throw Exception('Failed to load movies by cast');
  //   }
  //}
}
