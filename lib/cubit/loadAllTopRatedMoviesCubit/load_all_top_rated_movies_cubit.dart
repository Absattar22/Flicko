import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'load_all_top_rated_movies_state.dart';

class LoadAllTopRatedMoviesCubit extends Cubit<LoadAllTopRatedMoviesState> {
  LoadAllTopRatedMoviesCubit() : super(LoadAllTopRatedMoviesInitial());

  fetchTopRatedMovies() async {
    emit(LoadAllTopRatedMoviesLoading());
    try {
      final movies = await ApiService().fetchTopRatedMovies();
      emit(LoadAllTopRatedMoviesLoaded(movies));
    } catch (e) {
      emit(LoadAllTopRatedMoviesError('Failed to load top-rated movies'));
      print('Error fetching top-rated movies: $e'); // Debug log
    }
  }
}
