// movie.dart
class Movie {
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String language;
  final double voteAverage;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.language,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      language: json['original_language'] ?? 'Unknown',
      voteAverage: double.parse((json['vote_average'] as num).toString()).toDouble(),
    );
  }

  // Method to return the full image URL
  String fullImageUrl() {
    if (posterPath.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    } else {
      return ''; 
    }
  }
}
