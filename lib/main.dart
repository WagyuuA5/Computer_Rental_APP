import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_design_system/my_design_system.dart';
import 'core/injection.dart';
import 'features/catalog/presentation/pages/catalog_page.dart';
import 'features/booking/presentation/pages/my_bookings_page.dart';
import 'features/admin/presentation/pages/admin_panel_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Setup Firebase for appropriate platforms
  // await Firebase.initializeApp();
  await initDependencies();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computer Rental App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const MainNavigationPage(),
    );
  }
}


class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Rental App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              title: const Text('Katalog Unit'),
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
              title: const Text('Booking Saya'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyBookingsPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              title: const Text('Admin Panel'),
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

