part of 'top_rated_movies_cubit.dart';

@immutable
sealed class TopRatedMoviesState {}

final class TopRatedMoviesInitial extends TopRatedMoviesState {}

final class TopRatedMoviesLoading extends TopRatedMoviesState {}

final class TopRatedMoviesLoaded extends TopRatedMoviesState {
  final List<Movie> movies;

  TopRatedMoviesLoaded(this.movies);
}

final class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesError(this.message);
}
