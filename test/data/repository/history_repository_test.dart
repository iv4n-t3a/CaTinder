import 'package:app/data/history/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/domain/entities/cat.dart';

void main() {
  late Cat testCat;
  late HistoryRepositoryImpl testedRepo = HistoryRepositoryImpl();

  setUp(() {
    testCat = Cat(
      breed: 'b',
      description: "c",
      temperament: "d",
      lifeSpan: "e",
      origin: "f",
      imageUrl: "g",
    ); // Example Cat object
  });

  test('likes should return a list of liked cats', () async {
    final likedCats = [testCat];

    final result = await testedRepo.likes;

    expect(result, likedCats);
  });

  test('breeds should return a list of cat breeds', () async {
    final breeds = ['Siamese', 'Persian'];

    final result = await testedRepo.breeds;

    expect(result, breeds);
  });

  test('getLikeDate should return the like date of a cat', () async {
    final likeDate = DateTime.now();

    final result = await testedRepo.getLikeDate(testCat);

    expect(result, likeDate);
  });

  test('likesCount should return the number of likes', () async {
    const count = 5;

    final result = await testedRepo.likesCount;

    expect(result, count);
  });
}
