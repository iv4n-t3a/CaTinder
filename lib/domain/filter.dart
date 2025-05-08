import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FilterState {
  final Map<String, bool> enabled;

  FilterState({required this.enabled});

  static Future<FilterState> allEnabled() async {
    final breeds = await GetIt.I.get<HistoryRepository>().breeds;
    return FilterState(enabled: {
      for (String breed in breeds) breed: true,
    });
  }
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState(enabled: {})) {
    _initialize();
  }

  Future<void> _initialize() async {
    final initialState = await FilterState.allEnabled();
    emit(initialState);
  }

  Future<void> removeLike(Cat cat) async {
    await GetIt.I.get<HistoryRepository>().removeLike(cat);
    final newState = await FilterState.allEnabled();

    for (String k in state.enabled.keys) {
      newState.enabled[k] = state.enabled[k]!;
    }

    emit(newState);
  }

  void setBreed(String breed, bool value) {
    final enabled = Map<String, bool>.from(state.enabled);
    enabled[breed] = value;
    emit(FilterState(enabled: enabled));
  }

  Stream<Cat> get filteredItems async* {
    final likes = await GetIt.I.get<HistoryRepository>().likes;
    for (Cat i in likes) {
      if (!state.enabled[i.breed]!) {
        continue;
      }
      yield i;
    }
  }

  Map<String, bool> get filterMap => state.enabled;
}

