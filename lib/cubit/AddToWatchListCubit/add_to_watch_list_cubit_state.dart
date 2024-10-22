part of 'add_to_watch_list_cubit_cubit.dart';


@immutable
sealed class AddToWatchListCubitState {}

final class AddToWatchListCubitInitial extends AddToWatchListCubitState {}


class AddToWatchListCubitLoading extends AddToWatchListCubitState {}

class WatchlistLoaded extends AddToWatchListCubitState {
  final List<dynamic> watchlist;
  WatchlistLoaded(this.watchlist);
}

class AddToWatchListCubitError extends AddToWatchListCubitState {
  final String message;
  AddToWatchListCubitError(this.message);
}

class AddToWatchListCubitUpdated extends AddToWatchListCubitState {
  final String message;
  AddToWatchListCubitUpdated(this.message);
}

