import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../utils/dummy_data.dart';
import '../../widgets/sewa_card.dart';
import '../../widgets/confirmation_dialog.dart';
import '../models/add_sewa_screen.dart';
import '../models/edit_sewa_screen.dart';
import '../models/detail_sewa_screen.dart';

class DataSewaScreen extends StatefulWidget {
  const DataSewaScreen({super.key});

  @override
  State<DataSewaScreen> createState() => _DataSewaScreenState();
}

class _DataSewaScreenState extends State<DataSewaScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredList = DummyData.sewaList.where((sewa) {
      return sewa.namaPenyewa
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Sewa',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Cari nama penyewa...',
                        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // LIST DATA
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 80,
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tidak ada data ditemukan',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final sewa = filteredList[index];

                        return SewaCard(
                          sewa: sewa,

                          // OPEN DETAIL
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailSewaScreen(data: sewa),
                              ),
                            );
                          },

                          // EDIT
                          onEdit: () async {
                            final updatedData = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditSewaScreen(data: sewa),
                              ),
                            );

                            if (updatedData != null) {
                              setState(() {
                                final indexOld = DummyData.sewaList.indexOf(sewa);
                                DummyData.sewaList[indexOld] = updatedData;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data berhasil diperbarui'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          },

                          // DELETE
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                title: 'Hapus Data Sewa?',
                                message:
                                    'Apakah Anda yakin ingin menghapus data sewa atas nama ${sewa.namaPenyewa}?',
                                onConfirm: () {
                                  setState(() {
                                    DummyData.sewaList.remove(sewa);
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Data berhasil dihapus'),
                                      backgroundColor: AppColors.success,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newData = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSewaScreen()),
          );

          if (newData != null) {
            setState(() {
              DummyData.sewaList.add(newData);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data berhasil ditambahkan'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Sewa'),
      ),
    );
  }
}
