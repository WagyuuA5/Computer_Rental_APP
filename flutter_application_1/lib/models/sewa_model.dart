import 'package:intl/intl.dart';

class SewaModel {
  final String id;
  final String nama;
  final String alamat;
  final String barang;
  final String harga; 
  final String tanggal;

  final int jumlahKomputer;
  final int durasiJam;
  final double totalHarga;

  final DateTime tanggalMulai;

  SewaModel({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.barang,
    required this.harga,
    required this.tanggal,
    required this.jumlahKomputer,
    required this.durasiJam,
    required this.totalHarga,
    required this.tanggalMulai,
  });

  String get namaPenyewa => nama;

  String get formattedTanggal =>
      DateFormat('dd MMM yyyy').format(tanggalMulai);

  factory SewaModel.fromMap(Map<String, dynamic> map) {
    int parseInt(dynamic v, [int fallback = 1]) {
      if (v == null) return fallback;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? fallback;
    }

    double parseDouble(dynamic v, [double fallback = 0]) {
      if (v == null) return fallback;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse(v.toString().replaceAll(',', '')) ?? fallback;
    }

    DateTime parseDate(dynamic v) {
      if (v == null) return DateTime.now();
      if (v is DateTime) return v;

      try {
        return DateTime.parse(v.toString());
      } catch (_) {}

      return DateFormat('dd-MM-yyyy').parse(v.toString(), true);
    }

    final rawDate = map['tanggal'] ?? map['tanggalMulai'] ?? '';

    return SewaModel(
      id: map['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      nama: map['nama']?.toString() ?? map['namaPenyewa']?.toString() ?? '',
      alamat: map['alamat']?.toString() ?? '',
      barang: map['barang']?.toString() ?? '',
      harga: map['harga']?.toString() ?? '',
      tanggal: rawDate.toString(),
      jumlahKomputer: parseInt(map['jumlahKomputer']),
      durasiJam: parseInt(map['durasiJam']),
      totalHarga: parseDouble(map['totalHarga']),
      tanggalMulai: parseDate(rawDate),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nama": nama,
      "alamat": alamat,
      "barang": barang,
      "harga": harga,
      "tanggal": tanggal,
      "jumlahKomputer": jumlahKomputer,
      "durasiJam": durasiJam,
      "totalHarga": totalHarga,
      "tanggalMulai": tanggalMulai.toIso8601String(),
    };
  }

  SewaModel copyWith({
    String? id,
    String? nama,
    String? alamat,
    String? barang,
    String? harga,
    String? tanggal,
    int? jumlahKomputer,
    int? durasiJam,
    double? totalHarga,
    DateTime? tanggalMulai,
  }) {
    return SewaModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      barang: barang ?? this.barang,
      harga: harga ?? this.harga,
      tanggal: tanggal ?? this.tanggal,
      jumlahKomputer: jumlahKomputer ?? this.jumlahKomputer,
      durasiJam: durasiJam ?? this.durasiJam,
      totalHarga: totalHarga ?? this.totalHarga,
      tanggalMulai: tanggalMulai ?? this.tanggalMulai,
    );
  }
}
