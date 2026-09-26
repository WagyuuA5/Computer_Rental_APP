import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_design_system/my_design_system.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../domain/entities/rental_unit.dart';
import '../../../booking/domain/usecases/calculate_booking_price.dart';
import '../../../payment/presentation/pages/checkout_page.dart';

class UnitDetailPage extends ConsumerStatefulWidget {
  final RentalUnit unit;
  
  const UnitDetailPage({super.key, required this.unit});

  @override
  ConsumerState<UnitDetailPage> createState() => _UnitDetailPageState();
}

class _UnitDetailPageState extends ConsumerState<UnitDetailPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStart;
  DateTime? _selectedEnd;
  
  // Mock disabled dates (e.g., booked dates)
  final List<DateTime> _bookedDates = [
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 7)),
  ];

  bool _isDayBooked(DateTime day) {
    return _bookedDates.any((bookedDay) => 
      bookedDay.year == day.year && 
      bookedDay.month == day.month && 
      bookedDay.day == day.day
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (_isDayBooked(selectedDay)) return;
    
    setState(() {
      _focusedDay = focusedDay;
      
      if (_selectedStart == null) {
        _selectedStart = selectedDay;
        _selectedEnd = null;
      } else if (_selectedStart != null && _selectedEnd == null) {
        if (selectedDay.isBefore(_selectedStart!)) {
          _selectedStart = selectedDay;
        } else {
          // Validate range doesn't contain booked dates
          bool hasBookedInBetween = false;
          DateTime d = _selectedStart!;
          while (d.isBefore(selectedDay) || d.isAtSameMomentAs(selectedDay)) {
            if (_isDayBooked(d)) {
              hasBookedInBetween = true;
              break;
            }
            d = d.add(const Duration(days: 1));
          }
          
          if (hasBookedInBetween) {
            _selectedStart = selectedDay;
            _selectedEnd = null;
          } else {
            _selectedEnd = selectedDay;
          }
        }
      } else {
        _selectedStart = selectedDay;
        _selectedEnd = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.unit.description),
                const SizedBox(height: 8),
                Text('RAM: ${widget.unit.ramGB}GB'),
                Text('GPU: ${widget.unit.gpu}'),
                const SizedBox(height: 8),
                Text(
                  'Harga: Rp ${widget.unit.pricePerDay.toInt()}/hari',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Pilih Tanggal Sewa:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          AppCard(
            padding: const EdgeInsets.all(8),
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              rangeStartDay: _selectedStart,
              rangeEndDay: _selectedEnd,
              selectedDayPredicate: (day) => 
                _selectedStart != null && isSameDay(day, _selectedStart) ||
                _selectedEnd != null && isSameDay(day, _selectedEnd),
              rangeSelectionMode: RangeSelectionMode.enforced,
              enabledDayPredicate: (day) => !_isDayBooked(day),
              onDaySelected: _onDaySelected,
              calendarStyle: const CalendarStyle(
                disabledTextStyle: TextStyle(color: Colors.grey),
                disabledDecoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          if (_selectedStart != null) ...[
            const SizedBox(height: 16),
            const Text('Rincian Harga:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Builder(
                builder: (context) {
                  int durationDays = 1;
                  if (_selectedEnd != null) {
                    durationDays = _selectedEnd!.difference(_selectedStart!).inDays + 1;
                  }
                  
                  final calculator = CalculateBookingPrice();
                  final result = calculator(
                    durationDays: durationDays,
                    pricePerDay: widget.unit.pricePerDay,
                    additionalFees: 0, // Mock fee
                  );
                  
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Durasi ($durationDays hari) x Rp ${widget.unit.pricePerDay.toInt()}'),
                          Text('Rp ${result.subtotal.toInt()}'),
                        ],
                      ),
                      if (result.discount > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Diskon (10%)', style: TextStyle(color: Colors.green)),
                            Text('- Rp ${result.discount.toInt()}', style: const TextStyle(color: Colors.green)),
                          ],
                        ),
                      if (result.additionalFees > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Biaya Tambahan'),
                            Text('Rp ${result.additionalFees.toInt()}'),
                          ],
                        ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Rp ${result.total.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: (_selectedStart != null) ? () {
              int durationDays = 1;
              if (_selectedEnd != null) {
                durationDays = _selectedEnd!.difference(_selectedStart!).inDays + 1;
              }
              final calculator = CalculateBookingPrice();
              final result = calculator(
                durationDays: durationDays,
                pricePerDay: widget.unit.pricePerDay,
                additionalFees: 0,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutPage(
                    unit: widget.unit,
                    startDate: _selectedStart!,
                    endDate: _selectedEnd ?? _selectedStart!,
                    totalPrice: result.total,
                  ),
                ),
              );
            } : null,
            child: const Text('Lanjut Booking'),
          ),
        ),
      ),
    );
  }
}
