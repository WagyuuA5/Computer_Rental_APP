import '../models/sewa_model.dart';

class DummyData {
  static List<SewaModel> sewaList = [
    SewaModel(
      id: '1',
      nama: 'Ahmad Rizki',
      alamat: 'Jl. Merdeka No. 10',
      barang: 'Rental PC untuk gaming',
      harga: '5000', // harga per jam (string) — sesuai model lama
      tanggal: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      jumlahKomputer: 3,
      durasiJam: 4,
      totalHarga: 5000 * 3 * 4.toDouble(), // 5000 * 3 * 4 = 60000.0
      tanggalMulai: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SewaModel(
      id: '2',
      nama: 'Siti Nurhaliza',
      alamat: 'Jl. Kenangan No. 5',
      barang: 'Sewa 1 PC untuk desain',
      harga: '5000',
      tanggal: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      jumlahKomputer: 1,
      durasiJam: 2,
      totalHarga: 5000 * 1 * 2.toDouble(),
      tanggalMulai: DateTime.now().subtract(const Duration(days: 1)),
    ),
    SewaModel(
      id: '3',
      nama: 'Budi Santoso',
      alamat: 'Jl. Mawar No. 23',
      barang: 'Sewa 5 PC untuk tim',
      harga: '5000',
      tanggal: DateTime.now().toIso8601String(),
      jumlahKomputer: 5,
      durasiJam: 3,
      totalHarga: 5000 * 5 * 3.toDouble(),
      tanggalMulai: DateTime.now(),
    ),
    SewaModel(
      id: '4',
      nama: 'Diana Puspita',
      alamat: 'Jl. Melati No. 7',
      barang: 'Belajar kelompok',
      harga: '5000',
      tanggal: DateTime.now().toIso8601String(),
      jumlahKomputer: 2,
      durasiJam: 5,
      totalHarga: 5000 * 2 * 5.toDouble(),
      tanggalMulai: DateTime.now(),
    ),
  ];

  static Map<String, dynamic> userData = {
    'name': 'Mr. Wahyu',
    'email': 'whyuravi.2008@gmail.com',
    'phone': '+62 856-2440-3664',
    'role': 'Admin',
  };
}
