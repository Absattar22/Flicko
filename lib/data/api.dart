// api_service.dart
import 'dart:convert';
import 'package:flicko/models/movie_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiKey = '';

  Future<List<Movie>> fetchPopularMovies() async {
    final url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }
  Future<List<Movie>> searchMovies(String query) async {
    final url = 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
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
}
