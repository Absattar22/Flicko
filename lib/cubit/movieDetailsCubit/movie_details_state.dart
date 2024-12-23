part of 'movie_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;
  final List<Backdrop> backdrop;
  final List<Movie> similarMovies;

  MovieDetailsLoaded(this.movie , this.backdrop , this.similarMovies);
}

final class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}
