import '../models/rental_unit_model.dart';

abstract class RentalRemoteDataSource {
  Future<List<RentalUnitModel>> getUnits();
  Future<RentalUnitModel> getUnitDetail(String id);
}

class RentalRemoteDataSourceMockImpl implements RentalRemoteDataSource {
  final List<RentalUnitModel> _mockData = [
    RentalUnitModel(
      id: '1',
      name: 'High-End Gaming PC',
      description: 'PC Gaming dengan performa maksimal untuk game AAA.',
      imageUrl: 'https://via.placeholder.com/150',
      pricePerHour: 15000,
      pricePerDay: 150000,
      ramGB: 32,
      gpu: 'RTX 4080',
    ),
    RentalUnitModel(
      id: '2',
      name: 'Standard Gaming PC',
      description: 'PC Gaming standar untuk E-Sports.',
      imageUrl: 'https://via.placeholder.com/150',
      pricePerHour: 10000,
      pricePerDay: 100000,
      ramGB: 16,
      gpu: 'RTX 3060',
    ),
    RentalUnitModel(
      id: '3',
      name: 'Office / Productivity PC',
      description: 'PC ringan untuk keperluan kerja dan browsing.',
      imageUrl: 'https://via.placeholder.com/150',
      pricePerHour: 5000,
      pricePerDay: 50000,
      ramGB: 8,
      gpu: 'Integrated',
    ),
  ];

  @override
  Future<List<RentalUnitModel>> getUnits() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }

  @override
  Future<RentalUnitModel> getUnitDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData.firstWhere((unit) => unit.id == id);
  }
}
