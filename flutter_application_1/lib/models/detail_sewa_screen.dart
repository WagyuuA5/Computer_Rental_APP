import 'package:flutter/material.dart';
import '../../models/sewa_model.dart';

class DetailSewaScreen extends StatelessWidget {
  final SewaModel data;

  const DetailSewaScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Sewa")),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                detail("Nama Penyewa", data.nama),
                detail("Alamat", data.alamat),
                detail("Barang", data.barang),
                detail("Harga", "Rp ${data.harga}"),
                detail("Tanggal", data.tanggal),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Kembali"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
