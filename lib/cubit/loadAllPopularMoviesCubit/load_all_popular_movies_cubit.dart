import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'load_all_popular_movies_state.dart';

class LoadAllPopularMoviesCubit extends Cubit<LoadAllPopularMoviesState> {
  int page = 1;
  bool isFetching = false;
  List<Movie> allMovies = [];

  LoadAllPopularMoviesCubit() : super(LoadAllPopularMoviesInitial());

  fetchAllPopularMovies({bool fromPagination = false}) async {
    if (isFetching) return;
    isFetching = true;

    if (fromPagination) {
      emit(LoadAllPopularMoviesPaginationLoading(allMovies));
    } else {
      emit(LoadAllPopularMoviesLoading());
    }

    try {
      final newMovies = await ApiService().fetchPopularMovies(page: page);
      allMovies.addAll(newMovies);

      page++;
      emit(LoadAllPopularMoviesLoaded(allMovies));
    } catch (e) {
      emit(LoadAllPopularMoviesError('Failed to load popular movies'));
    } finally {
      isFetching = false;
    }
  }
}
