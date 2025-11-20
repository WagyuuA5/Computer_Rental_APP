// lib/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isLoading = true;
  List<PcRentalItem> _favoritePcs = [];
  final List<PcRentalItem> _allPcs = [
    PcRentalItem(
      id: 'pc001',
      name: 'Gaming Beast Pro',
      cpu: 'Intel Core i9-14900K',
      ram: '64GB DDR5',
      gpu: 'NVIDIA RTX 4090',
      storage: '4TB NVMe SSD',
      pricePerDay: 89.99,
      imageUrl: 'https://via.placeholder.com/150?text=Gaming+PC',
    ),
    PcRentalItem(
      id: 'pc002',
      name: 'Creator Studio Elite',
      cpu: 'AMD Ryzen 9 7950X',
      ram: '128GB DDR5',
      gpu: 'NVIDIA RTX 6000 Ada',
      storage: '8TB NVMe SSD + 16TB HDD',
      pricePerDay: 149.99,
      imageUrl: 'https://via.placeholder.com/150?text=Workstation',
    ),
    PcRentalItem(
      id: 'pc003',
      name: 'Compact Gaming Mini',
      cpu: 'Intel Core i7-13700H',
      ram: '32GB DDR5',
      gpu: 'NVIDIA RTX 4070 Laptop',
      storage: '2TB NVMe SSD',
      pricePerDay: 59.99,
      imageUrl: 'https://via.placeholder.com/150?text=Mini+PC',
    ),
  ];

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteIds = prefs.getStringList('favorites') ?? [];
    
    // Match favorite IDs with full PC data
    final List<PcRentalItem> favorites = _allPcs
        .where((pc) => favoriteIds.contains(pc.id))
        .toList();

    setState(() {
      _favoritePcs = favorites;
      _isLoading = false;
    });
  }

  Future<void> _removeFromFavorites(String pcId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(pcId);
    await prefs.setStringList('favorites', favorites);
    _loadFavorites(); // Refresh list
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: Colors.pink.shade700,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoritePcs.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favoritePcs.length,
                  itemBuilder: (context, index) {
                    final pc = _favoritePcs[index];
                    return _buildFavoriteCard(context, pc);
                  },
                ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            const Text(
              'Get started with favorites',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the heart icon on any PC to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text('Find new favorites'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, PcRentalItem pc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                pc.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.computer, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pc.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildSpecRow('RAM:', pc.ram),
                  _buildSpecRow('GPU:', pc.gpu),
                  const SizedBox(height: 8),
                  Text(
                    '\$${pc.pricePerDay.toStringAsFixed(2)}/day',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _removeFromFavorites(pc.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
class PcRentalItem {
  final String id;
  final String name;
  final String cpu;
  final String ram;
  final String gpu;
  final String storage;
  final double pricePerDay;
  final String imageUrl;

  PcRentalItem({
    required this.id,
    required this.name,
    required this.cpu,
    required this.ram,
    required this.gpu,
    required this.storage,
    required this.pricePerDay,
    required this.imageUrl,
  });
}