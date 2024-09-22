part of 'load_all_top_rated_movies_cubit.dart';

@immutable
sealed class LoadAllTopRatedMoviesState {}

final class LoadAllTopRatedMoviesInitial extends LoadAllTopRatedMoviesState {}

final class LoadAllTopRatedMoviesLoading extends LoadAllTopRatedMoviesState {}

final class LoadAllTopRatedMoviesLoaded extends LoadAllTopRatedMoviesState {
  final List<Movie> movies;

  LoadAllTopRatedMoviesLoaded(this.movies);
}

final class LoadAllTopRatedMoviesError extends LoadAllTopRatedMoviesState {
  final String message;

  LoadAllTopRatedMoviesError(this.message);
}
