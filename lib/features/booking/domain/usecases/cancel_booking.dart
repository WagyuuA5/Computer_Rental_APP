import '../../../../core/services/notification_service.dart';
import '../entities/booking.dart';

class CancelBooking {
  final NotificationService notificationService;

  CancelBooking(this.notificationService);

  Future<Booking> call(Booking booking) async {
    final cancelledBooking = booking.copyWith(status: BookingStatus.cancelled);
    
    final notificationId = booking.id.hashCode;
    await notificationService.cancelReminder(notificationId);

    return cancelledBooking;
  }
}
