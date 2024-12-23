part of 'now_playing_cubit.dart';

@immutable
sealed class NowPlayingMoviesState {}

final class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  
}

final class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  final List<Movie> movies;

  NowPlayingMoviesLoaded(this.movies);
}

final class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);
}
