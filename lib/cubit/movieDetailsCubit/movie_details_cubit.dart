import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/images_model.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  fetchMovieDetails(int movieId) async {
  emit(MovieDetailsLoading());
  try {
    final movie = await ApiService().fetchMovieDetails(movieId);
    final images = await ApiService().fetchMovieImages(movieId);
    emit(MovieDetailsLoaded(movie , images));
    
  } catch (e) {
    print('Error fetching movie details: $e');  // Debug log
    emit(MovieDetailsError('Failed to load movie details: $e'));
  }
}

}
