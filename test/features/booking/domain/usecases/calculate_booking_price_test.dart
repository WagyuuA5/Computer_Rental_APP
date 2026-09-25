import 'package:flutter_test/flutter_test.dart';
import 'package:computer_rental_app/features/booking/domain/usecases/calculate_booking_price.dart';

void main() {
  late CalculateBookingPrice usecase;

  setUp(() {
    usecase = CalculateBookingPrice();
  });

  test('Durasi pendek (1 hari), tanpa biaya tambahan (tidak ada diskon)', () {
    final result = usecase(
      durationDays: 1,
      pricePerDay: 100000,
      additionalFees: 0,
    );

    expect(result.subtotal, 100000);
    expect(result.discount, 0);
    expect(result.additionalFees, 0);
    expect(result.total, 100000);
  });

  test('Durasi pendek (2 hari), dengan biaya tambahan (tidak ada diskon)', () {
    final result = usecase(
      durationDays: 2,
      pricePerDay: 100000,
      additionalFees: 50000,
    );

    expect(result.subtotal, 200000);
    expect(result.discount, 0);
    expect(result.additionalFees, 50000);
    expect(result.total, 250000);
  });

  test('Durasi panjang (3 hari), tanpa biaya tambahan (diskon 10%)', () {
    final result = usecase(
      durationDays: 3,
      pricePerDay: 100000,
      additionalFees: 0,
    );

    // subtotal = 300000
    // discount = 30000
    // total = 270000
    expect(result.subtotal, 300000);
    expect(result.discount, 30000);
    expect(result.additionalFees, 0);
    expect(result.total, 270000);
  });

  test('Durasi sangat panjang (5 hari), dengan biaya tambahan (diskon 10%)', () {
    final result = usecase(
      durationDays: 5,
      pricePerDay: 150000,
      additionalFees: 100000,
    );

    // subtotal = 750000
    // discount = 75000
    // total = 750000 - 75000 + 100000 = 775000
    expect(result.subtotal, 750000);
    expect(result.discount, 75000);
    expect(result.additionalFees, 100000);
    expect(result.total, 775000);
  });

  test('Error saat durasi 0 atau negatif', () {
    expect(
      () => usecase(durationDays: 0, pricePerDay: 100000),
      throwsA(isA<ArgumentError>()),
    );
    expect(
      () => usecase(durationDays: -1, pricePerDay: 100000),
      throwsA(isA<ArgumentError>()),
    );
  });
}
