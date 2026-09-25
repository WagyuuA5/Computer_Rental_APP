import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_design_system/my_design_system.dart';
import '../../domain/entities/booking.dart';
import '../widgets/booking_timeline_widget.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  String _selectedStatus = 'All';

  // Mock Bookings
  final List<Booking> _allBookings = [
    Booking(
      id: 'B1',
      unitId: 'U1',
      userId: 'user1',
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(hours: 5)),
      status: BookingStatus.ongoing,
    ),
    Booking(
      id: 'B2',
      unitId: 'U2',
      userId: 'user1',
      startDate: DateTime.now().add(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 4)),
      status: BookingStatus.confirmed,
    ),
    Booking(
      id: 'B3',
      unitId: 'U3',
      userId: 'user1',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 3)),
      status: BookingStatus.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBookings = _selectedStatus == 'All'
        ? _allBookings
        : _allBookings.where((b) => b.status.name.toLowerCase() == _selectedStatus.toLowerCase()).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Saya'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) {
              setState(() {
                _selectedStatus = val;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('Semua')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
              const PopupMenuItem(value: 'Confirmed', child: Text('Confirmed')),
              const PopupMenuItem(value: 'Ongoing', child: Text('Ongoing')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
              const PopupMenuItem(value: 'Cancelled', child: Text('Cancelled')),
            ],
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
      body: filteredBookings.isEmpty
          ? const Center(child: Text('Tidak ada booking.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                final booking = filteredBookings[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking ID: ${booking.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Mulai: ${booking.startDate.toString().substring(0, 16)}'),
                        Text('Selesai: ${booking.endDate.toString().substring(0, 16)}'),
                        const SizedBox(height: 16),
                        BookingTimelineWidget(currentStatus: booking.status),
                        if (booking.status == BookingStatus.ongoing) ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          _CountdownWidget(endDate: booking.endDate),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _CountdownWidget extends StatefulWidget {
  final DateTime endDate;
  const _CountdownWidget({required this.endDate});

  @override
  State<_CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<_CountdownWidget> {
  Timer? _timer;
  Duration _timeLeft = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
    });
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    if (widget.endDate.isAfter(now)) {
      setState(() {
        _timeLeft = widget.endDate.difference(now);
      });
    } else {
      setState(() {
        _timeLeft = Duration.zero;
      });
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeft == Duration.zero) {
      return const Text('Waktu sewa telah habis.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
    }

    final hours = _timeLeft.inHours;
    final minutes = _timeLeft.inMinutes.remainder(60);
    final seconds = _timeLeft.inSeconds.remainder(60);

    return Text(
      'Sisa Waktu: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
