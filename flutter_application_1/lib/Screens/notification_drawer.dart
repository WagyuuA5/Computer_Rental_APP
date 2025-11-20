// lib/widgets/notification/notification_drawer.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart'; 

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? Colors.black : Colors.grey.shade50;
    final appBarColor = isDarkMode ? Colors.black : Colors.white;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0,
              foregroundColor: isDarkMode ? Colors.white : Colors.black,
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All notifications marked as read')),
                    );
                  },
                  icon: Icon(
                    Icons.done_all_outlined,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? Colors.white : Colors.black54,
                  ),
                ),
              ],
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    color: appBarColor,
                    child: TabBar(
                      indicatorColor: AppColors.primary,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: isDarkMode ? Colors.white70 : Colors.grey,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      tabs: const [
                        Tab(text: 'Messages'),
                        Tab(text: 'Notifications'),
                      ],
                      dividerHeight: 0,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildMessagesTab(context, scrollController, isDarkMode),
                        _buildNotificationsTab(context, scrollController, isDarkMode),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessagesTab(BuildContext context, ScrollController controller, bool isDarkMode) {
    final messages = [
      {
        'sender': 'Admin Support',
        'avatar': 'A',
        'subject': 'Your rental request is confirmed!',
        'preview': 'Your Gaming Beast Pro is reserved for Nov 25–30.',
        'time': '2 hours ago',
        'isRead': true,
      },
      {
        'sender': 'Billing Team',
        'avatar': 'B',
        'subject': 'Payment Reminder',
        'preview': 'Your invoice #PC-8891 is due in 2 days.',
        'time': '1 day ago',
        'isRead': false,
      },
      {
        'sender': 'System',
        'avatar': 'S',
        'subject': 'New feature available',
        'preview': 'You can now rent PCs by the hour!',
        'time': '3 days ago',
        'isRead': false,
      },
    ];

    final unreadCount = messages.where((m) => m['isRead'] == false).length;

    if (messages.isEmpty) {
      return _buildEmptyState(isDarkMode, 'No messages yet', 'You’ll receive messages from admin here.');
    }

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isRead = msg['isRead'] == true;

        return GestureDetector(
          onTap: () {
            // Mark as read on tap
            if (!isRead) {
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade900 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  foregroundColor: AppColors.primary,
                  child: Text(msg['avatar'] as String),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            msg['sender'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            msg['time'] as String,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white60 : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        msg['subject'] as String,
                        style: TextStyle(
                          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        msg['preview'] as String,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (!isRead)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationsTab(BuildContext context, ScrollController controller, bool isDarkMode) {
    final notifications = [
      {
        'icon': Icons.payment,
        'title': 'Payment Processed',
        'body': 'Your payment of \$89.99 for Nov 25–30 rental was successful.',
        'time': '3 hours ago',
        'isRead': true,
      },
      {
        'icon': Icons.new_releases,
        'title': 'New PC Available!',
        'body': 'Introducing the Creator Studio Elite – rent it now at 10% off.',
        'time': '1 day ago',
        'isRead': false,
      },
      {
        'icon': Icons.warning_amber,
        'title': 'Rental Ending Soon',
        'body': 'Your current rental ends in 2 days. Extend or return on time.',
        'time': '2 days ago',
        'isRead': false,
      },
    ];

    if (notifications.isEmpty) {
      return _buildEmptyState(isDarkMode, 'No notifications', 'You’ll receive system alerts here.');
    }

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notif = notifications[index];
        final isRead = notif['isRead'] == true;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notif['icon'] as IconData,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif['title'] as String,
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          notif['time'] as String,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white60 : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notif['body'] as String,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isDarkMode, String title, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off,
              size: 60,
              color: isDarkMode ? Colors.white30 : Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 15,
                color: isDarkMode ? Colors.white60 : Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}