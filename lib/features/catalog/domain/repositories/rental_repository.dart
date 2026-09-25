import '../entities/rental_unit.dart';

abstract class RentalRepository {
  Future<List<RentalUnit>> getUnits();
  Future<RentalUnit> getUnitDetail(String id);
}
