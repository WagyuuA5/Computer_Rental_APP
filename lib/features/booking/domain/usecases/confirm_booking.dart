import '../../../../core/services/notification_service.dart';
import '../entities/booking.dart';

class ConfirmBooking {
  final NotificationService notificationService;

  ConfirmBooking(this.notificationService);

  Future<Booking> call(Booking booking) async {
    final confirmedBooking = booking.copyWith(status: BookingStatus.confirmed);
    
    // Jadwalkan reminder H-1 sebelum startDate
    final reminderTime = booking.startDate.subtract(const Duration(days: 1));
    
    // Konversi string ID ke integer sederhana untuk notifikasi
    final notificationId = booking.id.hashCode;

    await notificationService.scheduleReminder(
      id: notificationId,
      title: 'Reminder Sewa Komputer',
      body: 'Sewa komputer Anda (Booking ${booking.id}) akan dimulai besok!',
      scheduledTime: reminderTime,
    );

    return confirmedBooking;
  }
}
