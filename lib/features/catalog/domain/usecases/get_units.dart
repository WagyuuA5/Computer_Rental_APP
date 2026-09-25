import '../entities/rental_unit.dart';
import '../repositories/rental_repository.dart';

class GetUnits {
  final RentalRepository repository;

  GetUnits(this.repository);

  Future<List<RentalUnit>> call() async {
    return await repository.getUnits();
  }
}
