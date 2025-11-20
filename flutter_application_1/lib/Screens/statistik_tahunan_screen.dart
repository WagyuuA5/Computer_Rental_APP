import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class StatistikTahunanScreen extends StatelessWidget {
  const StatistikTahunanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> bulan = [
      "Jan","Feb","Mar","Apr","Mei","Jun",
      "Jul","Agu","Sep","Okt","Nov","Des"
    ];

    List<int> pendapatan = [
      400000, 350000, 380000, 420000, 500000, 550000,
      480000, 530000, 600000, 580000, 610000, 700000
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistik Tahunan"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // GRAFIK PENDAPATAN
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(12, (i) {
                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        height: pendapatan[i] / 15000,
                        width: 18,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        bulan[i],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Tabel Statistik Pendapatan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(bulan[i],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("Rp ${pendapatan[i]}",
                            style: const TextStyle(
                                color: AppColors.success,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
