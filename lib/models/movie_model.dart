class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String language;
  final double rating;
  final List<String> genres;
  final String filePath;
  final int duration;

  Movie({
    required this.genres,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.language,
    required this.rating,
    required this.filePath,
    required this.duration,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> genreNames = [];
    if (json['genres'] != null && json['genres'].isNotEmpty) {
      genreNames = (json['genres'] as List).map((genre) {
        String genreName = genre['name'] as String;
        if (genreName == 'Science Fiction') {
          return 'Sci-Fi';
        }
        return genreName;
      }).toList();
    }
    return Movie(
      genres: genreNames,
      id: json['id'],
      title: json['title'] ?? 'No Title Available',
      overview: json['overview'] ?? 'No Overview Available',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      language: json['original_language'] ?? 'Unknown',
      rating: (json['vote_average'] != null)
          ? double.parse(json['vote_average'].toString())
          : 0.0,
      filePath: json['backdrop_path'] ?? '',
      duration: json['runtime'] ?? 0,
    );
  }

  String fullImageUrl() {
    if (posterPath.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    } else {
      return '';
    }
  }

  String fullFilePath() {
    if (filePath.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w500$filePath';
    } else {
      return '';
    }
  }
}
