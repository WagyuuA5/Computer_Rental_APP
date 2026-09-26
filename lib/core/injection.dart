import 'package:get_it/get_it.dart';

import '../features/catalog/data/datasources/rental_remote_datasource.dart';
import '../features/catalog/data/repositories/rental_repository_impl.dart';
import '../features/catalog/domain/repositories/rental_repository.dart';
import '../features/catalog/domain/usecases/get_units.dart';
import '../features/catalog/domain/usecases/get_unit_detail.dart';
import '../features/booking/domain/usecases/confirm_booking.dart';
import '../features/booking/domain/usecases/cancel_booking.dart';
import 'services/notification_service.dart';
import 'services/payment_service.dart';
import 'services/invoice_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Services
  final notificationService = NotificationService();
  await notificationService.init();
  sl.registerSingleton<NotificationService>(notificationService);
  sl.registerLazySingleton<PaymentService>(() => PaymentService());
  sl.registerLazySingleton<InvoiceService>(() => InvoiceService());

  // Datasources
  sl.registerLazySingleton<RentalRemoteDataSource>(() => RentalRemoteDataSourceMockImpl());

  // Repositories
  sl.registerLazySingleton<RentalRepository>(() => RentalRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => GetUnits(sl()));
  sl.registerLazySingleton(() => GetUnitDetail(sl()));
  sl.registerLazySingleton(() => ConfirmBooking(sl()));
  sl.registerLazySingleton(() => CancelBooking(sl()));
}

