import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_to_watch_list_cubit_state.dart';

class AddToWatchListCubitCubit extends Cubit<AddToWatchListCubitState> {
  AddToWatchListCubitCubit() : super(AddToWatchListCubitInitial());
}
