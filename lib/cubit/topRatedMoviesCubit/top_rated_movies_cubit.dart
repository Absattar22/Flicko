import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  
  TopRatedMoviesCubit() : super(TopRatedMoviesInitial());

   fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    try {
      final movies = await ApiService().fetchTopRatedMovies();
      emit(TopRatedMoviesLoaded(movies));
    } catch (e) {
      emit(TopRatedMoviesError('Failed to load top-rated movies'));
    }
  }
}
