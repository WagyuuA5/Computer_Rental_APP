import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/injection.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
          ListTile(
            title: const Text('Katalog Unit'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Catalog
            },
          ),
          ListTile(
            title: const Text('Booking Saya'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to My Bookings
            },
          ),
          ListTile(
            title: const Text('Admin Panel'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Admin
            },
          ),
        ],
      ),
    );
  }
}
