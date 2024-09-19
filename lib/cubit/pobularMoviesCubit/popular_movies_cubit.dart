import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(PopularMoviesInitial());

   fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    try {
      final movies = await ApiService().fetchPopularMovies();
      emit(PopularMoviesLoaded(movies));
    } catch (e) {
      emit(PopularMoviesError('Failed to load popular movies'));
    }
  }
}
