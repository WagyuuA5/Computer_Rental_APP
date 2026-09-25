import 'package:flutter_test/flutter_test.dart';
import 'package:computer_rental_app/features/booking/domain/entities/booking.dart';
import 'package:computer_rental_app/features/booking/domain/usecases/check_booking_overlap.dart';

void main() {
  late CheckBookingOverlap usecase;

  setUp(() {
    usecase = CheckBookingOverlap();
  });

  Booking createBooking(DateTime start, DateTime end, {String status = 'confirmed'}) {
    return Booking(
      id: '1',
      unitId: 'unit_1',
      userId: 'user_1',
      startDate: start,
      endDate: end,
      status: status,
    );
  }

  test('Tidak overlap sama sekali (jauh sebelum)', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 1),
      newEnd: DateTime(2026, 10, 5),
      existingBookings: existing,
    );
    expect(result, isFalse);
  });

  test('Tidak overlap sama sekali (jauh sesudah)', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 20),
      newEnd: DateTime(2026, 10, 25),
      existingBookings: existing,
    );
    expect(result, isFalse);
  });

  test('Overlap total (tanggal sama persis)', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 10),
      newEnd: DateTime(2026, 10, 15),
      existingBookings: existing,
    );
    expect(result, isTrue);
  });

  test('Overlap sebagian di awal', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 8),
      newEnd: DateTime(2026, 10, 12),
      existingBookings: existing,
    );
    expect(result, isTrue);
  });

  test('Overlap sebagian di akhir', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 14),
      newEnd: DateTime(2026, 10, 18),
      existingBookings: existing,
    );
    expect(result, isTrue);
  });

  test('Rentang baru membungkus rentang existing', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 5),
      newEnd: DateTime(2026, 10, 20),
      existingBookings: existing,
    );
    expect(result, isTrue);
  });

  test('Rentang existing membungkus rentang baru', () {
    final existing = [
      createBooking(DateTime(2026, 10, 5), DateTime(2026, 10, 20)),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 10),
      newEnd: DateTime(2026, 10, 15),
      existingBookings: existing,
    );
    expect(result, isTrue);
  });

  test('Kasus bersentuhan tepat di tanggal batas (back-to-back check-out check-in)', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15)),
    ];
    // Check-in on the 15th, same day as existing check-out. Should NOT overlap.
    final result1 = usecase(
      newStart: DateTime(2026, 10, 15),
      newEnd: DateTime(2026, 10, 20),
      existingBookings: existing,
    );
    expect(result1, isFalse);

    // Check-out on the 10th, same day as existing check-in. Should NOT overlap.
    final result2 = usecase(
      newStart: DateTime(2026, 10, 5),
      newEnd: DateTime(2026, 10, 10),
      existingBookings: existing,
    );
    expect(result2, isFalse);
  });

  test('Booking existing yang dibatalkan tidak menyebabkan overlap', () {
    final existing = [
      createBooking(DateTime(2026, 10, 10), DateTime(2026, 10, 15), status: 'cancelled'),
    ];
    final result = usecase(
      newStart: DateTime(2026, 10, 10),
      newEnd: DateTime(2026, 10, 15),
      existingBookings: existing,
    );
    expect(result, isFalse);
  });
}
