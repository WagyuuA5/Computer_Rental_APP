enum BookingStatus {
  pending,
  confirmed,
  ongoing,
  completed,
  cancelled,
}

extension BookingStatusExtension on BookingStatus {
  String get name {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.ongoing:
        return 'Ongoing';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class Booking {
  final String id;
  final String unitId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.unitId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  // Example state machine transition method (could be moved to a usecase)
  Booking copyWith({BookingStatus? status}) {
    return Booking(
      id: id,
      unitId: unitId,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      status: status ?? this.status,
    );
  }
}
