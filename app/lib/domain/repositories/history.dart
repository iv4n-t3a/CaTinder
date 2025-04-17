import 'package:app/domain/entities/cat.dart';

abstract class HistoryRepository {
  void addLike(Cat cat);
  void removeLike(Cat cat);
  Iterable<Cat> get likes;
  Iterable<String> get breeds;
  DateTime getLikeDate(Cat cat);
  int get likesCount;
}
