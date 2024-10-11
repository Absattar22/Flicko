part of 'recommend_movies_cubit_cubit.dart';

@immutable
sealed class RecommendMoviesCubitState {}

final class RecommendMoviesCubitInitial extends RecommendMoviesCubitState {}

final class RecommendMoviesCubitLoading extends RecommendMoviesCubitState {}

final class RecommendMoviesCubitPaginationLoading
    extends RecommendMoviesCubitState {
  final List<Movie> movies;

  RecommendMoviesCubitPaginationLoading(this.movies);
}

final class RecommendMoviesCubitLoaded extends RecommendMoviesCubitState {
  final List<Movie> movies;

  RecommendMoviesCubitLoaded(this.movies);
}

final class RecommendMoviesCubitError extends RecommendMoviesCubitState {
  final String message;

  RecommendMoviesCubitError(this.message);
}
