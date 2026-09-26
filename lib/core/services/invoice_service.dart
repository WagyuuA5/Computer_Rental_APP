import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../../features/catalog/domain/entities/rental_unit.dart';

class InvoiceService {
  Future<File> generateInvoice({
    required String bookingId,
    required RentalUnit unit,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
    required String paymentMethod,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('INVOICE', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Booking ID: $bookingId'),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Detail Penyewaan:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                headers: ['Item', 'Deskripsi'],
                data: [
                  ['Unit', unit.name],
                  ['Spesifikasi', 'RAM: ${unit.ramGB}GB, GPU: ${unit.gpu}'],
                  ['Tanggal Mulai', startDate.toString().substring(0, 10)],
                  ['Tanggal Selesai', endDate.toString().substring(0, 10)],
                  ['Harga per Hari', 'Rp ${unit.pricePerDay.toInt()}'],
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Metode Pembayaran: $paymentMethod'),
                  pw.Text('Total Tagihan: Rp ${totalPrice.toInt()}', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Spacer(),
              pw.Text('Terima kasih telah menggunakan layanan Computer Rental App!', style: const pw.TextStyle(color: PdfColors.grey)),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/invoice_$bookingId.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> shareInvoice(File file) async {
    // ignore: deprecated_member_use
    await Share.shareXFiles([XFile(file.path)], text: 'Ini adalah invoice penyewaan Anda.');
  }
}

