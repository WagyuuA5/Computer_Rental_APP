import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/favorites_screen.dart';
import 'package:flutter_application_1/Screens/search_screen.dart';
import '../config/app_colors.dart';
import '../Screens/dashboard_screen.dart';
import '../Screens/data_sewa_screen.dart';
import '../models/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SearchScreen(),
     const FavoritesScreen(),
    const DashboardScreen(),
     const DataSewaScreen(),
    const ProfileScreen(),
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.search, 'Search', 0),
                _buildNavItem(Icons.favorite_border, 'Favorites', 1),
                _buildNavItem(Icons.dashboard_rounded, 'Dashboard', 2),
                _buildNavItem(Icons.list_alt_rounded, 'Data Sewa', 3),
                _buildNavItem(Icons.more_horiz_rounded, 'More', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}