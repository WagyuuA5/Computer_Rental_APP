import '../entities/rental_unit.dart';
import '../repositories/rental_repository.dart';

class GetUnitDetail {
  final RentalRepository repository;

  GetUnitDetail(this.repository);

  Future<RentalUnit> call(String id) async {
    return await repository.getUnitDetail(id);
  }
}
