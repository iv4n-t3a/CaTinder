import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';

void main() {
  late Cat testCat;
  late HistoryRepository testedRepo;

  setUp(() {
    testCat = Cat(
      breed: 'b',
      description: "c",
      temperament: "d",
      lifeSpan: "e",
      origin: "f",
      imageUrl: "g",
    ); // Example Cat object
    testedRepo = GetIt.I.get<HistoryRepository>();
  });

  test('addLike should call addLike on the repository', () async {
    when(testedRepo.addLike(testCat)).thenAnswer((_) async {});

    await testedRepo.addLike(testCat);

    verify(testedRepo.addLike(testCat)).called(1);
  });

  test('removeLike should call removeLike on the repository', () async {
    when(testedRepo.removeLike(testCat)).thenAnswer((_) async {});

    await testedRepo.removeLike(testCat);

    verify(testedRepo.removeLike(testCat)).called(1);
  });

  test('likes should return a list of liked cats', () async {
    final likedCats = [testCat];
    when(testedRepo.likes).thenAnswer((_) async => likedCats);

    final result = await testedRepo.likes;

    expect(result, likedCats);
  });

  test('breeds should return a list of cat breeds', () async {
    final breeds = ['Siamese', 'Persian'];
    when(testedRepo.breeds).thenAnswer((_) async => breeds);

    final result = await testedRepo.breeds;

    expect(result, breeds);
  });

  test('getLikeDate should return the like date of a cat', () async {
    final likeDate = DateTime.now();
    when(testedRepo.getLikeDate(testCat))
        .thenAnswer((_) async => likeDate);

    final result = await testedRepo.getLikeDate(testCat);

    expect(result, likeDate);
  });

  test('likesCount should return the number of likes', () async {
    const count = 5;
    when(testedRepo.likesCount).thenAnswer((_) async => count);

    final result = await testedRepo.likesCount;

    expect(result, count);
  });
}
