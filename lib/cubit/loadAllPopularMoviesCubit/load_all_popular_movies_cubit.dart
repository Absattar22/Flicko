import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'load_all_popular_movies_state.dart';

class LoadAllPopularMoviesCubit extends Cubit<LoadAllPopularMoviesState> {
  LoadAllPopularMoviesCubit() : super(LoadAllPopularMoviesInitial());

  fetchAllPopularMovies() async {
    emit(LoadAllPopularMoviesLoading());
    try {
      final movies = await ApiService().fetchPopularMovies();
      emit(LoadAllPopularMoviesLoaded(movies));
    } catch (e) {
      emit(LoadAllPopularMoviesError('Failed to load popular movies'));
    }
  }
}

