import 'package:app/data/database/database.dart';
import 'package:app/data/history/repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/domain/entities/cat.dart';

void main() {
  late Cat testCat;
  late HistoryRepositoryImpl testedRepo = HistoryRepositoryImpl(
    db: AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    ),
  );

  setUp(() {
    testCat = Cat(
      breed: 'b',
      description: "c",
      temperament: "d",
      lifeSpan: "e",
      origin: "f",
      imageUrl: "g",
    ); // Example Cat object
    testedRepo.addLike(testCat);
  });

  test('likes should return a list of liked cats', () async {
    final result = await testedRepo.likes;

    expect(result.length, 1);
    expect(result.first.imageUrl, testCat.imageUrl);
  });

  test('breeds should return a list of cat breeds', () async {
    final breeds = [testCat.breed];

    final result = await testedRepo.breeds;

    expect(result, breeds);
  });

  test('likesCount should return the number of likes', () async {
    final result = await testedRepo.likesCount;

    expect(result, 1);
  });

  test("can't like one cat twice", () async {
    testedRepo.addLike(testCat);
    testedRepo.addLike(testCat);
    testedRepo.addLike(testCat);
    testedRepo.addLike(testCat);

    final result = await testedRepo.likesCount;

    expect(result, 1);
  });
}
