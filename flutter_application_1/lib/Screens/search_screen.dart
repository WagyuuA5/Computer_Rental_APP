
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PcRentalItem {
  final String id;
  final String name;
  final String modelYear;
  final String cpu;
  final String ram;
  final String gpu;
  final String storage;
  final double pricePerDay;
  final double rating;
  final int trips;
  final String imageUrl;

  PcRentalItem({
    required this.id,
    required this.name,
    required this.modelYear,
    required this.cpu,
    required this.ram,
    required this.gpu,
    required this.storage,
    required this.pricePerDay,
    required this.rating,
    required this.trips,
    required this.imageUrl,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PcRentalItem> allPcs = [
    PcRentalItem(
      id: 'pc001',
      name: 'Gaming Beast Pro',
      modelYear: '2025',
      cpu: 'Intel Core i9-14900K',
      ram: '64GB DDR5',
      gpu: 'NVIDIA RTX 4090',
      storage: '4TB NVMe SSD',
      pricePerDay: 89.99,
      rating: 4.8,
      trips: 35,
      imageUrl: 'Assets/images/pc7.jpg',
    ),
    PcRentalItem(
      id: 'pc002',
      name: 'Creator Studio Elite',
      modelYear: '2024',
      cpu: 'AMD Ryzen 9 7950X',
      ram: '128GB DDR5',
      gpu: 'NVIDIA RTX 6000 Ada',
      storage: '8TB NVMe SSD + 16TB HDD',
      pricePerDay: 149.99,
      rating: 5.0,
      trips: 9,
       imageUrl: 'Assets/images/pc1.jpg',
    ),
    PcRentalItem(
      id: 'pc003',
      name: 'Compact Gaming Mini',
      modelYear: '2023',
      cpu: 'Intel Core i7-13700H',
      ram: '32GB DDR5',
      gpu: 'NVIDIA RTX 4070 Laptop',
      storage: '2TB NVMe SSD',
      pricePerDay: 59.99,
      rating: 4.9,
      trips: 46,
      imageUrl: 'Assets/images/pc3.jpg',
    ),
    PcRentalItem(
      id: 'pc004',
      name: 'Desktop Beast Pro',
      modelYear: '2025',
      cpu: 'Intel Core i9-14900K',
      ram: '64GB DDR5',
      gpu: 'NVIDIA RTX 4090',
      storage: '10TB NVMe SSD',
      pricePerDay: 90.99,
      rating: 4.9,
      trips: 35,
      imageUrl: 'Assets/images/pc15.jpg',
    ),
    PcRentalItem(
      id: 'pc005',
      name: 'Vibox VBX-PC',
      modelYear: '2025',
      cpu: 'Intel Core i9-14900K',
      ram: '64GB DDR5',
      gpu: 'NVIDIA RTX 4090',
      storage: '10TB NVMe SSD',
      pricePerDay: 90.99,
      rating: 4.9,
      trips: 35,
      imageUrl: 'Assets/images/pc4.jpg',
    ),
  ];

  List<PcRentalItem> filteredPcs = [];

  final ScrollController _latestController = ScrollController();
  final ScrollController _highPerformanceController = ScrollController();

  @override
  void initState() {
    super.initState();
    filteredPcs = allPcs;
  }

  @override
  void dispose() {
    _latestController.dispose();
    _highPerformanceController.dispose();
    super.dispose();
  }

  Future<void> toggleFavorite(String pcId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (favorites.contains(pcId)) {
      favorites.remove(pcId);
    } else {
      favorites.add(pcId);
    }
    await prefs.setStringList('favorites', favorites);
    setState(() {});
  } 

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPcs = allPcs;
      } else {
        filteredPcs = allPcs.where((pc) {
          return pc.name.toLowerCase().contains(query.toLowerCase()) ||
              pc.cpu.toLowerCase().contains(query.toLowerCase()) ||
              pc.gpu.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void showMoreMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account & Settings'),
        content: const Text('Ini adalah menu untuk akun pengguna/admin (Sesuai permintaan Anda).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showNotificationCenter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 400,
        child: Column(
          children: [
            ListTile(title: Text('Notification Center', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Messages'),
                        Tab(text: 'Notifications'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Center(child: Text('Inbox (Keluhan & Masukan)')),
                          Center(child: Text('Notifikasi Sistem (Promo, Konfirmasi)')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search PC or Spec...',
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.blue),
          ),
          onChanged: _onSearchChanged,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.blue),
            onPressed: () => _showNotificationCenter(context),
          ),
          // Ikon More (Tiga Titik) untuk Profil/Akun
          // IconButton(
          //   icon: const Icon(Icons.more_vert, color: Colors.blue),
          //   onPressed: () => _showMoreMenu(context),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildCategoryChip(label: 'All PCs', isSelected: true),
                  const SizedBox(width: 8),
                  _buildCategoryChip(label: 'Gaming', isSelected: false),
                  const SizedBox(width: 8),
                  _buildCategoryChip(label: 'Creator', isSelected: false),
                ],
              ),
            ),

            _buildHorizontalSection(
              title: 'Latest PC Rental',
              controller: _latestController,
              items: filteredPcs,
            ),

            const SizedBox(height: 32),

            _buildHorizontalSection(
              title: 'High-Performance PC for Work & Gaming',
              controller: _highPerformanceController,
              items: allPcs.where((pc) => pc.rating >= 4.8).toList(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip({required String label, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade700 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade800,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildHorizontalSection({
    required String title,
    required ScrollController controller,
    required List<PcRentalItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 950),
                    curve: Curves.easeOutCubic,
                  );
                },
                icon: const Icon(Icons.chevron_right, size: 24, color: Colors.blue),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final pc = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildPcCard(context, pc),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPcCard(BuildContext context, PcRentalItem pc) {
    return FutureBuilder<List<String>>(
      future: SharedPreferences.getInstance().then((prefs) => prefs.getStringList('favorites') ?? []),
      builder: (context, snapshot) {
        final isFavorite = snapshot.data?.contains(pc.id) ?? false;
        return SizedBox(
          width: 200,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    pc.imageUrl,
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.computer, size: 50, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${pc.name} ${pc.modelYear}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () => toggleFavorite(pc.id),
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey.shade400,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              pc.rating.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(${pc.trips} rentals)',
                              style: const TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                        Text(
                          '\$${pc.pricePerDay.toStringAsFixed(2)}/day',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}