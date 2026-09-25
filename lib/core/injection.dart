import 'package:get_it/get_it.dart';

import '../features/catalog/data/datasources/rental_remote_datasource.dart';
import '../features/catalog/data/repositories/rental_repository_impl.dart';
import '../features/catalog/domain/repositories/rental_repository.dart';
import '../features/catalog/domain/usecases/get_units.dart';
import '../features/catalog/domain/usecases/get_unit_detail.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Datasources
  sl.registerLazySingleton<RentalRemoteDataSource>(() => RentalRemoteDataSourceMockImpl());

  // Repositories
  sl.registerLazySingleton<RentalRepository>(() => RentalRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => GetUnits(sl()));
  sl.registerLazySingleton(() => GetUnitDetail(sl()));
}

