class Booking {
  final String id;
  final String unitId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  Booking({
    required this.id,
    required this.unitId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
}
