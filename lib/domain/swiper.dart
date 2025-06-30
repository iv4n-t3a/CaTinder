import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class SwiperState {
  final Future<Cat> catFuture;

  const SwiperState({
    required this.catFuture,
  });
}

class SwiperCubit extends Cubit<SwiperState> {
  SwiperCubit() : super(_nextState());

  void like() async {
    try {
      Cat cat = await state.catFuture;
      GetIt.I.get<HistoryRepository>().addLike(cat);
      emit(_nextState());
    } catch (e) {
      emit(_nextState()); // just going to next card
    }
  }

  void dislike() {
    emit(_nextState());
  }

  static SwiperState _nextState() {
    return SwiperState(
      catFuture: GetIt.I.get<CatLoader>().loadCat(),
    );
  }
}
