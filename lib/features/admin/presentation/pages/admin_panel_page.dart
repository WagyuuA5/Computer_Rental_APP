import 'package:flutter/material.dart';
import 'package:my_design_system/my_design_system.dart';
import '../../../../core/injection.dart';
import '../../../booking/domain/entities/booking.dart';
import '../../../booking/domain/usecases/confirm_booking.dart';
import '../../../booking/domain/usecases/cancel_booking.dart';
import '../../../booking/presentation/widgets/booking_timeline_widget.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  // Mock Pending Bookings
  final List<Booking> _pendingBookings = [
    Booking(
      id: 'B_PENDING_1',
      unitId: 'U1',
      userId: 'user2',
      startDate: DateTime.now().add(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 4)),
      status: BookingStatus.pending,
    ),
    Booking(
      id: 'B_PENDING_2',
      unitId: 'U3',
      userId: 'user3',
      startDate: DateTime.now().add(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 7)),
      status: BookingStatus.pending,
    ),
  ];

  Future<void> _approveBooking(Booking booking, int index) async {
    final confirmUsecase = sl<ConfirmBooking>();
    final updatedBooking = await confirmUsecase(booking);
    
    setState(() {
      _pendingBookings[index] = updatedBooking;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking Approved!')),
      );
    }
  }

  Future<void> _rejectBooking(Booking booking, int index) async {
    final cancelUsecase = sl<CancelBooking>();
    final updatedBooking = await cancelUsecase(booking);
    
    setState(() {
      _pendingBookings[index] = updatedBooking;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking Rejected!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only show pending bookings for admin action
    final visibleBookings = _pendingBookings.where((b) => b.status == BookingStatus.pending).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel - Approvals'),
      ),
      body: visibleBookings.isEmpty
          ? const Center(child: Text('Tidak ada booking pending.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: visibleBookings.length,
              itemBuilder: (context, index) {
                // Find original index
                final originalIndex = _pendingBookings.indexOf(visibleBookings[index]);
                final booking = visibleBookings[index];
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking ID: ${booking.id} (User: ${booking.userId})', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Unit ID: ${booking.unitId}'),
                        Text('Mulai: ${booking.startDate.toString().substring(0, 10)}'),
                        Text('Selesai: ${booking.endDate.toString().substring(0, 10)}'),
                        const SizedBox(height: 16),
                        BookingTimelineWidget(currentStatus: booking.status),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              icon: const Icon(Icons.close, color: Colors.white),
                              label: const Text('Reject', style: TextStyle(color: Colors.white)),
                              onPressed: () => _rejectBooking(booking, originalIndex),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              icon: const Icon(Icons.check, color: Colors.white),
                              label: const Text('Approve', style: TextStyle(color: Colors.white)),
                              onPressed: () => _approveBooking(booking, originalIndex),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
