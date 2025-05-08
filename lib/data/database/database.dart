import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app/data/history/db_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [HistoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // As it's training app, migration just drops everything
        onUpgrade: (migrator, from, to) async {
          for (final table in allTables) {
            await migrator.deleteTable(table.actualTableName);
          }
          await migrator.createAll();
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'catinder_iv4n-t3a_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
