import 'package:flutter/material.dart';
import 'package:my_design_system/my_design_system.dart';
import '../../../../core/injection.dart';
import '../../../../core/services/payment_service.dart';
import '../../../../core/services/invoice_service.dart';
import '../../../catalog/domain/entities/rental_unit.dart';

class CheckoutPage extends StatefulWidget {
  final RentalUnit unit;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;

  const CheckoutPage({
    super.key,
    required this.unit,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isProcessing = false;
  String _selectedPaymentMethod = 'Bank Transfer / Virtual Account';

  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    final paymentService = sl<PaymentService>();
    final success = await paymentService.processPayment(
      bookingId: 'NEW_BOOKING_123',
      amount: widget.totalPrice,
      paymentMethod: _selectedPaymentMethod,
    );

    setState(() {
      _isProcessing = false;
    });

    if (success && mounted) {
      // Payment success! We will mock creating the booking.
      // After payment, the status becomes 'Confirmed' (or 'Pending' for admin approval).
      // Based on PR 11 prompt: "Tambahkan flow bayar di halaman checkout setelah confirm booking." 
      // So let's say it becomes Pending, wait PR 10 said Admin approves pending bookings.
      // So User pays -> Status Pending. Admin approves -> Status Confirmed.
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Pembayaran Berhasil'),
          content: const Text('Booking Anda telah masuk dan menunggu persetujuan Admin (Pending).'),
          actions: [
            TextButton(
              onPressed: () async {
                final invoiceService = sl<InvoiceService>();
                final file = await invoiceService.generateInvoice(
                  bookingId: 'NEW_BOOKING_123',
                  unit: widget.unit,
                  startDate: widget.startDate,
                  endDate: widget.endDate,
                  totalPrice: widget.totalPrice,
                  paymentMethod: _selectedPaymentMethod,
                );
                await invoiceService.shareInvoice(file);
              },
              child: const Text('Share Invoice (PDF)'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                Navigator.of(context).pop(); // close checkout
                Navigator.of(context).pop(); // back to catalog
              },
              child: const Text('Selesai'),
            ),
          ],
        ),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pembayaran gagal! Silakan coba lagi.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Pembayaran')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Detail Penyewaan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                Text('Unit: ${widget.unit.name}'),
                Text('Tanggal Mulai: ${widget.startDate.toString().substring(0, 10)}'),
                Text('Tanggal Selesai: ${widget.endDate.toString().substring(0, 10)}'),
                const Divider(),
                Text(
                  'Total Tagihan: Rp ${widget.totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedPaymentMethod,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: ['Bank Transfer / Virtual Account', 'Credit Card', 'E-Wallet', 'Qris']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedPaymentMethod = val;
                });
              }
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Bayar Sekarang'),
            ),
          ),
        ],
      ),
    );
  }
}
