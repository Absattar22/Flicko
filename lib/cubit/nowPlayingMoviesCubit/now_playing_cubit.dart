import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'now_playing_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  
  NowPlayingMoviesCubit() : super(NowPlayingMoviesInitial());

   fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());
    try {
      final movies = await ApiService().fetchNowPlayingMovies();
      emit(NowPlayingMoviesLoaded(movies));
    } catch (e) {
      emit(NowPlayingMoviesError('Failed to load now playing movies'));
    }
  }
}
