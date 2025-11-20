import 'package:flutter/material.dart';
import '../../models/sewa_model.dart';

class EditSewaScreen extends StatefulWidget {
  final SewaModel data;

  const EditSewaScreen({super.key, required this.data});

  @override
  State<EditSewaScreen> createState() => _EditSewaScreenState();
}

class _EditSewaScreenState extends State<EditSewaScreen> {
  late TextEditingController namaC;
  late TextEditingController alamatC;
  late TextEditingController barangC;
  late TextEditingController hargaC;
  late TextEditingController tanggalC;
  late TextEditingController jumlahC;
  late TextEditingController durasiC;

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.data.nama);
    alamatC = TextEditingController(text: widget.data.alamat);
    barangC = TextEditingController(text: widget.data.barang);
    hargaC = TextEditingController(text: widget.data.harga);
    tanggalC = TextEditingController(text: widget.data.tanggal);
    jumlahC = TextEditingController(text: widget.data.jumlahKomputer.toString());
    durasiC = TextEditingController(text: widget.data.durasiJam.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Sewa")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            input("Nama Penyewa", namaC),
            input("Alamat", alamatC),
            input("Barang", barangC),
            input("Harga ", hargaC),
            input("Tanggal", tanggalC),
            input("Jumlah Komputer", jumlahC),
            input("Durasi ", durasiC),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final jumlah = int.tryParse(jumlahC.text) ?? 1;
                final durasi = int.tryParse(durasiC.text) ?? 1;
                final hargaPerJam =
                    double.tryParse(hargaC.text.replaceAll('.', '')) ?? 0;

                final total = hargaPerJam * jumlah * durasi;

                final updated = widget.data.copyWith(
                  nama: namaC.text,
                  alamat: alamatC.text,
                  barang: barangC.text,
                  harga: hargaC.text,
                  tanggal: tanggalC.text,
                  jumlahKomputer: jumlah,
                  durasiJam: durasi,
                  totalHarga: total,
                  tanggalMulai:
                      DateTime.tryParse(tanggalC.text) ?? widget.data.tanggalMulai,
                );

                Navigator.pop(context, updated);
              },
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }

  Widget input(String title, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
