// lib/Screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import 'statistik_tahunan_screen.dart';
import '../Screens/notification_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const NotificationDrawer(),
              );
            },
            icon: const Icon(Icons.notifications_outlined, size: 28),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GREETING
              const Text(
                "Hello! 👋",
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 6),
              const Text(
                "Mr. Wahyu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),
              GridView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.2,
                ),
                children: [
                  _statCard("Total Rental", "3", Icons.receipt_long, AppColors.primary),
                  _statCard("PC Tersewa", "6", Icons.computer, AppColors.info),
                  _statCard("Pendapatan", "Rp 120.000", Icons.monetization_on, AppColors.success),
                  _statCard("Hari Ini", "1", Icons.calendar_month, AppColors.error),
                ],
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Statistik Mingguan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StatistikTahunanScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 15),
              _WeeklyStatsChart(),
              const SizedBox(height: 30),

              const Text(
                "Transaksi Terbaru",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              _lastTransaction("Ahmad Rizki", "3 PC • 4 Jam", "Rp 60.000"),
              _lastTransaction("Siti Nurhaliza", "1 PC • 2 Jam", "Rp 10.000"),
              _lastTransaction("Diana Puspita", "2 PC • 5 Jam", "Rp 50.000"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 10),
            color: AppColors.shadowColor,
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _lastTransaction(String name, String detail, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.computer, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(detail, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                ],
              )
            ],
          ),
          Text(
            amount,
            style: const TextStyle(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyStatsChart extends StatefulWidget {
  @override
  State<_WeeklyStatsChart> createState() => _WeeklyStatsChartState();
}

class _WeeklyStatsChartState extends State<_WeeklyStatsChart> {
  late List<int> values;
  late List<String> days;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    values = [40, 25, 38, 27, 45, 52, 20];
    days = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: values.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("Tapped ${days[index]}: ${values[index]}");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutBack,
                          height: values[index].toDouble(),
                          width: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.7),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 6,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          days[index],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}