import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FilterState {
  final Map<String, bool> enabled;

  FilterState({required this.enabled});

  factory FilterState.allEnabled() {
    return FilterState(enabled: {
      for (String breed in GetIt.I.get<HistoryRepository>().breeds) breed: true
    });
  }
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.allEnabled());

  void removeLike(Cat cat) {
    GetIt.I.get<HistoryRepository>().removeLike(cat);
    FilterState newState = FilterState.allEnabled();

    for (String k in state.enabled.keys) {
      newState.enabled[k] = state.enabled[k]!;
    }

    emit(newState);
  }

  void setBreed(String breed, bool value) {
    Map<String, bool> enabled = state.enabled;
    enabled[breed] = value;
    emit(FilterState(enabled: enabled));
  }

  Iterable<Cat> get filteredItems sync* {
    for (Cat i in GetIt.I.get<HistoryRepository>().likes) {
      if (!state.enabled[i.breed]!) {
        continue;
      }
      yield i;
    }
  }

  Map<String, bool> get filterMap => state.enabled;
}
