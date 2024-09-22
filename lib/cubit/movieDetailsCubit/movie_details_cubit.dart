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
      final similarMovies = await ApiService().fetchSimilarMovies(movieId);
      emit(MovieDetailsLoaded(movie, images, similarMovies));
    } catch (e) {
      emit(MovieDetailsError('Failed to load movie details: $e'));
    }
  }
}
