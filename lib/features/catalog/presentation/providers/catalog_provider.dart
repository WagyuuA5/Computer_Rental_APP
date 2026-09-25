import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/injection.dart';
import '../../domain/entities/rental_unit.dart';
import '../../domain/usecases/get_units.dart';
import '../../domain/usecases/get_unit_detail.dart';

final getUnitsProvider = Provider<GetUnits>((ref) {
  return sl<GetUnits>();
});

final getUnitDetailProvider = Provider<GetUnitDetail>((ref) {
  return sl<GetUnitDetail>();
});

final catalogFutureProvider = FutureProvider<List<RentalUnit>>((ref) async {
  final getUnits = ref.read(getUnitsProvider);
  return await getUnits();
});
