# 💻 Computer_Rental_APP - Simple Rental Solution
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Status](https://img.shields.io/badge/Status-Mid--Term--Project-orange?style=for-the-badge)

**Computer_Rental_APP** adalah aplikasi manajemen penyewaan komputer yang dirancang untuk efisiensi dan kemudahan penggunaan. Dibuat sebagai **Proyek Tengah Semester 1** di **SMK Telkom Malang**, aplikasi ini menunjukkan progres pembelajaran fundamental Flutter dan Dart dengan pendekatan UI yang bersih.
---
## 🛠️ Arsitektur Proyek (Standard Structure)
Aplikasi ini dibangun dengan struktur folder yang terorganisir untuk memastikan skalabilitas dan kerapihan kode, sesuai dengan standar yang dipelajari di SMK Telkom Malang.

```text
lib/
├── ⚙️ config/      # Tema (Dark/Light), Warna, & Konstanta Aplikasi
├── 📄 models/      # Blueprint Data & Object Mapping (SewaModel)
├── 🗺️ navigation/  # Logika Navigasi & Bottom Navigation Bar
├── 🖼️ screens/     # Antarmuka Utama (Dashboard, Stats, Data Sewa)
├── 🧩 utils/       # Data Dummy & Fungsi Pembantu (Helper)
└── 📦 widgets/     # Komponen UI yang dapat digunakan kembali

🚀 Fitur Unggulan
📊 Real-time Dashboard: Pantau total pendapatan, unit tersewa, dan statistik mingguan melalui grafik batang.

📈 Statistik Tahunan: Laporan pendapatan bulanan yang disajikan dalam bentuk tabel yang rapi.

💻 Smart Catalog: Daftar unit komputer (Gaming, Creator, Mini) lengkap dengan spesifikasi RAM & GPU.

📝 Comprehensive CRUD: Kelola data penyewa (Tambah, Edit, Cari, Hapus) dengan indikator status aktif.

🌓 Adaptive Theme: Dukungan penuh untuk mode terang dan gelap untuk kenyamanan pengguna.

💡 Catatan Pembelajaran
Proyek ini merupakan hasil eksplorasi mandiri dan bimbingan guru selama setengah semester pertama. Meskipun masih sangat sederhana dan menggunakan data statis (dummy), fokus utama proyek ini adalah:

Pemahaman Layouting (Row, Column, Stack, ListView).

Implementasi State Management sederhana (Provider).

Logika Filtering & Searching pada list data.

⚙️ Cara Menjalankan
Pastikan Flutter SDK sudah terinstal.

Clone repositori ini:

Bash
git clone [https://github.com/username/pc-lease-manager.git](https://github.com/username/pc-lease-manager.git)
Jalankan flutter pub get.

Jalankan aplikasi dengan flutter run.

Dibuat dengan ❤️ oleh Wahyu Ravi.
