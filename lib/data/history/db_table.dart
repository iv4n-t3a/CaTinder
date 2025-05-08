import 'package:drift/drift.dart';

class HistoryTable extends Table {
  TextColumn get catImageUrl => text().unique()();
  TextColumn get catOrigin => text()();
  TextColumn get catLifeSpan => text()();
  TextColumn get catTemperament => text()();
  TextColumn get catBreed => text()();
  TextColumn get catDescription => text()();
  DateTimeColumn get likeDate => dateTime().withDefault(currentDateAndTime)();
}
