import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_design_system/my_design_system.dart';
import '../providers/catalog_provider.dart';
import 'unit_detail_page.dart';

class CatalogPage extends ConsumerStatefulWidget {
  const CatalogPage({super.key});

  @override
  ConsumerState<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends ConsumerState<CatalogPage> {
  String _selectedSort = 'price_asc';

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Unit'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) {
              setState(() {
                _selectedSort = val;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'price_asc',
                child: Text('Harga Termurah'),
              ),
              const PopupMenuItem(
                value: 'price_desc',
                child: Text('Harga Termahal'),
              ),
            ],
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      body: catalogAsync.when(
        data: (units) {
          final sortedUnits = List.of(units);
          if (_selectedSort == 'price_asc') {
            sortedUnits.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour));
          } else {
            sortedUnits.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: sortedUnits.length,
            itemBuilder: (context, index) {
              final unit = sortedUnits[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UnitDetailPage(unit: unit),
                    ),
                  );
                },
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.computer, size: 50, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              unit.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text('RAM: ${unit.ramGB}GB | GPU: ${unit.gpu}'),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${unit.pricePerHour.toInt()}/jam',
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
