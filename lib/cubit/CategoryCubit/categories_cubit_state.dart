part of 'categories_cubit_cubit.dart';

@immutable
sealed class CategoriesCubitState {}

final class CategoriesCubitInitial extends CategoriesCubitState {}

final class CategoriesCubitLoading extends CategoriesCubitState {}

final class CategoriesCubitPaginationLoading extends CategoriesCubitState {
  final List<Movie> movies;

  CategoriesCubitPaginationLoading(this.movies);
}

final class CategoriesCubitLoaded extends CategoriesCubitState {
  final List<Movie> movies;

  CategoriesCubitLoaded(this.movies);
}

final class CategoriesCubitError extends CategoriesCubitState {
  final String message;

  CategoriesCubitError(this.message);
}


