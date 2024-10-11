import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'load_all_top_rated_movies_state.dart';

class LoadAllTopRatedMoviesCubit extends Cubit<LoadAllTopRatedMoviesState> {
  int page = 1;
  bool isFetching = false;
  List<Movie> allMovies = [];
  LoadAllTopRatedMoviesCubit() : super(LoadAllTopRatedMoviesInitial());

  fetchTopRatedMovies({bool fromPagination = false}) async {
    if (isFetching) return;
    isFetching = true;

    if (fromPagination) {
      emit(LoadAllTopRatedMoviesPaginationLoading(allMovies));
    } else {
      emit(LoadAllTopRatedMoviesLoading());
    }
    try {
      final newMovies = await ApiService().fetchTopRatedMovies(page: page);
      allMovies.addAll(newMovies);
      page++;
      emit(LoadAllTopRatedMoviesLoaded(allMovies));
    } catch (e) {
      emit(LoadAllTopRatedMoviesError('Failed to load top-rated movies'));
      print('Error fetching top-rated movies: $e'); // Debug log
    } finally {
      isFetching = false;
    }
  }
}
