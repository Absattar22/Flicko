import 'dart:convert';
import 'package:flicko/models/images_model.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '7d3ba24980dd60f55fa37fccea576fb6';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    final url = '$baseUrl/movie/popular?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies.where((movie) {
        return movie.language != 'ja' && movie.language != 'ko';
      }).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies({int page = 1}) async {
    final url = '$baseUrl/movie/top_rated?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies.where((movie) {
        return movie.language != 'ja' && movie.language != 'ko';
      }).toList();
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final url = '$baseUrl/movie/now_playing?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies.where((movie) {
        return movie.language != 'ja' && movie.language != 'ko';
      }).toList();
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final url = '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies.where((movie) {
        return movie.language != 'ja' && movie.language != 'ko';
      }).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = '$baseUrl/movie/$movieId?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Backdrop>> fetchMovieImages(int movieId) async {
    final url = '$baseUrl/movie/$movieId/images?api_key=$apiKey';
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
        '$baseUrl/movie/$movieId/recommendations?api_key=$apiKey&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies.where((movie) {
        return movie.language != 'ja' && movie.language != 'ko';
      }).toList();
    } else {
      throw Exception('Failed to load similar movies');
    }
  }

  Future<List<Movie>> fetchGenreMovies(dynamic genreId,
      {int page = 1, double minRating = 7.0}) async {
    final url =
        '$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies
          .where(
            (movie) =>
                movie.rating >= minRating &&
                movie.language != 'ko' &&
                movie.language != 'ja',
          )
          .toList();
    } else {
      throw Exception('Failed to load genre movies');
    }
  }

  Future<List<Movie>> fetchRecommendationWithGenres(
    dynamic genreId1,
    int genreId2, {
    int page = 1,
    double minRating = 7.5,
  }) async {
    final url =
        '$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId1,$genreId2&page=$page';
    print(url);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies.where((movie) {
        return movie.rating >= minRating &&
            movie.language != 'ko' &&
            movie.language != 'ja';
      }).toList();
    } else {
      throw Exception('Failed to load recommendation movies');
    }
  }

  Future<String?> createRequestToken() async {
    final url = '$baseUrl/authentication/token/new?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['request_token'];
    }
    return null;
  }

  Future<String?> createSession(String requestToken) async {
    final url = '$baseUrl/authentication/session/new?api_key=$apiKey';
    final response = await http.post(Uri.parse(url), body: {
      'request_token': requestToken,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['session_id'];
    }
    return null;
  }

  Future<bool> updateWatchlist(String sessionId, dynamic accountId, int movieId,
      bool addToWatchlist) async {
    final url =
        '$baseUrl/account/$accountId/watchlist?api_key=$apiKey&session_id=$sessionId';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode({
        "media_type": "movie",
        "media_id": movieId,
        "watchlist": addToWatchlist,
      }),
    );
    return response.statusCode == 201;
  }

  Future<List<dynamic>?> getWatchlist(String sessionId, int accountId) async {
    final url =
        '$baseUrl/account/$accountId/watchlist/movies?api_key=$apiKey&session_id=$sessionId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    }
    return null;
  }

  Future<int?> getAccountDetails(String sessionId) async {
    final url = '$baseUrl/account?api_key=$apiKey&session_id=$sessionId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['id'];
    }
    return null;
  }
}
