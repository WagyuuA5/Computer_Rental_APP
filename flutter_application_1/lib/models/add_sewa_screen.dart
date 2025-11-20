import 'package:flutter/material.dart';
import '../../models/sewa_model.dart';

class AddSewaScreen extends StatefulWidget {
  const AddSewaScreen({super.key});

  @override
  State<AddSewaScreen> createState() => _AddSewaScreenState();
}

class _AddSewaScreenState extends State<AddSewaScreen> {
  final namaC = TextEditingController();
  final alamatC = TextEditingController();
  final barangC = TextEditingController();
  final hargaC = TextEditingController();
  final tanggalC = TextEditingController();
  final jumlahC = TextEditingController();
  final durasiC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Sewa")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            input("Nama Penyewa", namaC),
            input("Alamat", alamatC),
            input("Barang", barangC),
            input("Harga (per Unit)", hargaC, number: true),
            input("Tanggal (YYYY-MM-DD)", tanggalC),
            input("Jumlah Komputer (PC)", jumlahC, number: true),
            input("Durasi ", durasiC, number: true),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final jumlah = int.tryParse(jumlahC.text) ?? 1;
                final durasi = int.tryParse(durasiC.text) ?? 1;
                final hargaPerJam =
                    double.tryParse(hargaC.text.replaceAll('.', '')) ?? 0;

                final total =
                    (hargaPerJam * jumlah * durasi).toDouble();

                final model = SewaModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  nama: namaC.text,
                  alamat: alamatC.text,
                  barang: barangC.text,
                  harga: hargaC.text,
                  tanggal: tanggalC.text,
                  jumlahKomputer: jumlah,
                  durasiJam: durasi,
                  totalHarga: total,
                  tanggalMulai: DateTime.tryParse(tanggalC.text) ?? DateTime.now(),
                );

                Navigator.pop(context, model);
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }

  Widget input(String title, TextEditingController c, {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
