import 'package:app/data/cats/loader.dart';
import 'package:app/data/database/database.dart';
import 'package:app/data/history/repository.dart';
import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:get_it/get_it.dart';

void setupServices() {
  GetIt.I.registerSingleton<CatLoader>(CatLoaderImpl());
  GetIt.I.registerSingleton<HistoryRepository>(HistoryRepositoryImpl(db: AppDatabase()));
}
