part of 'load_all_popular_movies_cubit.dart';

@immutable
sealed class LoadAllPopularMoviesState {}

final class LoadAllPopularMoviesInitial extends LoadAllPopularMoviesState {}

final class LoadAllPopularMoviesLoading extends LoadAllPopularMoviesState {}

final class LoadAllPopularMoviesLoaded extends LoadAllPopularMoviesState {
  final List<Movie> movies;

  LoadAllPopularMoviesLoaded(this.movies);
}
final class LoadAllPopularMoviesError extends LoadAllPopularMoviesState {
  final String message;

  LoadAllPopularMoviesError(this.message);
}
