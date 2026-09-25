import '../../domain/entities/rental_unit.dart';
import '../../domain/repositories/rental_repository.dart';
import '../datasources/rental_remote_datasource.dart';

class RentalRepositoryImpl implements RentalRepository {
  final RentalRemoteDataSource remoteDataSource;

  RentalRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RentalUnit>> getUnits() async {
    return await remoteDataSource.getUnits();
  }

  @override
  Future<RentalUnit> getUnitDetail(String id) async {
    return await remoteDataSource.getUnitDetail(id);
  }
}
