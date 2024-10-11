import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'recommend_movies_cubit_state.dart';

class RecommendMoviesCubit extends Cubit<RecommendMoviesCubitState> {
  RecommendMoviesCubit() : super(RecommendMoviesCubitInitial());
  int page = 1;
  bool isFetching = false;
  List<Movie> allMovies = [];

  fetchRecommendMovies(int id1, int id2, {bool fromPagination = false}) async {
    if (isFetching) return;
    isFetching = true;
    if (fromPagination) {
      emit(RecommendMoviesCubitPaginationLoading(allMovies));
    } else {
      emit(RecommendMoviesCubitLoading());
    }
    try {
      final newMovies =
          await ApiService().FetchRecomdationWithGenres(id1, id2, page: page);
      allMovies.addAll(newMovies);

      page++;
      emit(RecommendMoviesCubitLoaded(allMovies));
    } catch (e) {
      emit(RecommendMoviesCubitError('Failed to load recommended movies'));
    } finally {
      isFetching = false;
    }
  }
}
