import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'categories_cubit_state.dart';

class CategoriesCubit extends Cubit<CategoriesCubitState> {
  CategoriesCubit() : super(CategoriesCubitInitial());
  int page = 1;
  bool isFetching = false;
  List<Movie> allMovies = [];

  fetchCategories(int id, {bool fromPagination = false}) async {
    if (isFetching) return;
    isFetching = true;
    if (fromPagination) {
      emit(CategoriesCubitPaginationLoading(allMovies));
    } else {
      emit(CategoriesCubitLoading());
    }
    try {
      final newMovies = await ApiService().fetchGenreMovies(id, page: page);
      allMovies.addAll(newMovies);
      page++;

      emit(CategoriesCubitLoaded(allMovies));
    } catch (e) {
      emit(CategoriesCubitError('Failed to load categories'));
    } finally {
      isFetching = false;
    }
  }
}
