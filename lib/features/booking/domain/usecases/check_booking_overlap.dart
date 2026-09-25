import '../entities/booking.dart';

class CheckBookingOverlap {
  /// Checks if a new booking range overlaps with any existing bookings.
  /// 
  /// Business Rule:
  /// - A booking range is [startDate, endDate].
  /// - Two ranges overlap if the new start date is strictly before an existing end date,
  ///   AND the new end date is strictly after an existing start date.
  /// - This means back-to-back bookings (e.g., checkout on the 10th, checkin on the 10th)
  ///   are allowed (not considered an overlap).
  bool call({
    required DateTime newStart,
    required DateTime newEnd,
    required List<Booking> existingBookings,
  }) {
    if (newStart.isAfter(newEnd)) {
      throw ArgumentError('newStart cannot be after newEnd');
    }

    for (final booking in existingBookings) {
      if (booking.status == 'cancelled' || booking.status == 'rejected') {
        continue;
      }

      // Overlap condition: start1 < end2 AND start2 < end1
      if (newStart.isBefore(booking.endDate) && booking.startDate.isBefore(newEnd)) {
        return true; // Overlap detected
      }
    }

    return false; // No overlap
  }
}
