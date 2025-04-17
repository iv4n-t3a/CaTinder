import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final Set<Cat> _likes = {};
  final Map<Cat, DateTime> _time = {};

  @override
  void addLike(Cat cat) {
    _time[cat] = DateTime.now();
    _likes.add(cat);
  }

  @override
  void removeLike(Cat cat) {
    _time.remove(cat);
    _likes.remove(cat);
  }

  @override
  DateTime getLikeDate(Cat cat) {
    return _time[cat]!;
  }

  @override
  Iterable<Cat> get likes => _likes;

  @override
  Iterable<String> get breeds => Set.from(_likes.map((cat) => cat.breed));

  @override
  int get likesCount => _likes.length;
}
