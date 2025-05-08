import 'package:app/domain/entities/cat.dart';

abstract class HistoryRepository {
  Future<void> addLike(Cat cat);
  Future<void> removeLike(Cat cat);
  Future<Iterable<Cat>> get likes;
  Future<Iterable<String>> get breeds;
  Future<DateTime> getLikeDate(Cat cat);
  Future<int> get likesCount;
}
