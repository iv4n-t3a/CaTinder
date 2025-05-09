import 'package:app/data/database/database.dart';
import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:drift/drift.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final AppDatabase db;

  HistoryRepositoryImpl({
    required this.db,
  });

  @override
  Future<void> addLike(Cat cat) async {
    await db.into(db.historyTable).insert(
          HistoryTableCompanion.insert(
            catImageUrl: cat.imageUrl,
            catOrigin: cat.origin,
            catLifeSpan: cat.lifeSpan,
            catTemperament: cat.temperament,
            catBreed: cat.breed,
            catDescription: cat.description,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  @override
  Future<void> removeLike(Cat cat) async {
    await (db.delete(db.historyTable)
          ..where((tbl) => tbl.catImageUrl.equals(cat.imageUrl)))
        .go();
  }

  @override
  Future<DateTime> getLikeDate(Cat cat) async {
    final query = db.select(db.historyTable)
      ..where((tbl) => tbl.catImageUrl.equals(cat.imageUrl));
    final result = await query.getSingleOrNull();
    if (result == null) {
      throw Exception("Cat wasn't liked");
    }
    return result.likeDate;
  }

  @override
  Future<Iterable<Cat>> get likes async {
    final results = await db.select(db.historyTable).get();
    return results.map((row) => Cat(
          imageUrl: row.catImageUrl,
          origin: row.catOrigin,
          lifeSpan: row.catLifeSpan,
          temperament: row.catTemperament,
          breed: row.catBreed,
          description: row.catDescription,
        ));
  }

  @override
  Future<Iterable<String>> get breeds async {
    final query = db.selectOnly(db.historyTable, distinct: true)
      ..addColumns([db.historyTable.catBreed]);
    final results =
        await query.map((row) => row.read(db.historyTable.catBreed)!).get();
    return results;
  }

  @override
  Future<int> get likesCount async {
    return db.select(db.historyTable).get().then((list) => list.length);
  }
}
