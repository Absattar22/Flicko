import 'package:bloc/bloc.dart';
import 'package:flicko/data/api.dart';
import 'package:meta/meta.dart';

part 'add_to_watch_list_cubit_state.dart';

class AddToWatchListCubit extends Cubit<AddToWatchListCubitState> {
  final ApiService apiService;
  String? sessionId;
  int? accountId;

  AddToWatchListCubit({required this.apiService})
      : super(AddToWatchListCubitInitial());

  Future<void> login(String requestToken) async {
    emit(AddToWatchListCubitLoading());
    try {
      sessionId = await apiService.createSession(requestToken);
      if (sessionId != null) {
        // Fetch accountId using the account details API
        accountId = await apiService.getAccountDetails(sessionId!);
        // Fetch and load the watchlist
        await fetchWatchlist();
      }
    } catch (e) {
      emit(AddToWatchListCubitError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> fetchWatchlist() async {
    if (sessionId == null || accountId == null) {
      emit(AddToWatchListCubitError('User not logged in'));
      return;
    }
    emit(AddToWatchListCubitLoading());
    try {
      final watchlist = await apiService.getWatchlist(sessionId!, accountId!);
      emit(WatchlistLoaded(watchlist ?? []));
    } catch (e) {
      emit(AddToWatchListCubitError('Error fetching watchlist: ${e.toString()}'));
    }
  }

  Future<void> addToWatchList(int movieId, bool addToWatchlist) async {
    if (sessionId == null || accountId == null) {
      emit(AddToWatchListCubitError('User not logged in'));
      return;
    }
    emit(AddToWatchListCubitLoading());
    try {
      final success = await apiService.updateWatchlist(
          sessionId!, accountId!, movieId, addToWatchlist);
      if (success) {
        // After successfully adding/removing from watchlist, refresh the watchlist
        await fetchWatchlist();
        emit(AddToWatchListCubitUpdated(addToWatchlist
            ? 'Movie added to watchlist'
            : 'Movie removed from watchlist'));
      } else {
        emit(AddToWatchListCubitError('Failed to update watchlist'));
      }
    } catch (e) {
      emit(AddToWatchListCubitError('Error updating watchlist: ${e.toString()}'));
    }
  }
}
