

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/theme_provider.dart';
import 'package:flutter_application_1/models/account_settings_screen.dart';
// import 'package:flutter_application_1/models/info_account_screen.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'models/profile_provider.dart';
import 'screens/splash_screen.dart';
// import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'models/profile_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/data_sewa_screen.dart';
// import 'models/account_info_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Computer Rental Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        // '/login': (context) => const LoginScreen(),
        '/home': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/data-sewa': (context) => const DataSewaScreen(),
        '/account-info': (context) => const AccountSettingsScreen(),
        // '/info-account': (context) => const AccountInfoScreen(),
      },
    );
  }
}