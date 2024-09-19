// movie.dart
class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String language;
  final double rating;
  final List<int> genre;


  Movie({
    required this.genre,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.language,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      genre: List<int>.from(json['genre_ids']),
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      language: json['original_language'] ?? 'Unknown',
      rating: double.parse((json['vote_average'] as num).toString()).toDouble(),
    );
  }

  // Method to return the full image URL
  String fullImageUrl() {
    if (posterPath.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w400$posterPath';
    } else {
      return '';
    }
  }
}
