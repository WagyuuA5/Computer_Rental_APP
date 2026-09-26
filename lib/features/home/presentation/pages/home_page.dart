import 'package:flutter/material.dart';
import 'package:my_design_system/my_design_system.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';
import '../../../booking/presentation/pages/my_bookings_page.dart';
import '../../../admin/presentation/pages/admin_panel_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock summary data
    final int ongoingBookingsCount = 1;
    final int pendingApprovalsCount = 2; // for admin role

    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Rental Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (ongoingBookingsCount > 0)
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Anda memiliki $ongoingBookingsCount penyewaan yang sedang aktif.',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
          const Text('Menu Utama', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          AppCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Katalog Unit'),
              subtitle: const Text('Lihat dan sewa komputer'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CatalogPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Booking Saya'),
              subtitle: const Text('Kelola dan lihat status penyewaan'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyBookingsPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          const Text('Menu Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          AppCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Admin Panel'),
              subtitle: Text('$pendingApprovalsCount pengajuan pending'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminPanelPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
