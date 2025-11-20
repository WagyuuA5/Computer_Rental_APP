

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/profile_provider.dart';

class InfoAccountScreen extends StatelessWidget {
  const InfoAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? Colors.black : Colors.white;
    final text = isDark ? Colors.white : Colors.black;
    final subText = isDark ? Colors.white70 : Colors.grey[700];
    final cardBg = isDark ? Colors.grey[900] : Colors.grey[100];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Info Account"),
        centerTitle: true,
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: text,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: text),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildItem(
                  icon: Icons.email_outlined,
                  title: "Email",
                  subtitle: profile.email,
                  trailing: const Text(
                    "Verified",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: text,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email verification settings coming soon"),
                      ),
                    );
                  },
                ),

                _buildDivider(),

                _buildItem(
                  icon: Icons.lock_outline,
                  title: "Password",
                  subtitle: "Change your password",
                  textColor: text,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Change password feature coming soon"),
                      ),
                    );
                  },
                ),

                _buildDivider(),

                _buildItem(
                  icon: Icons.phone_android,
                  title: "Mobile Phone",
                  subtitle: "Not verified",
                  textColor: text,
                  trailing: const Text(
                    "Not verified",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Phone verification coming soon")),
                    );
                  },
                ),

                _buildDivider(),

                _buildItem(
                  icon: Icons.account_circle_outlined,
                  title: "Google Account",
                  subtitle: "Connected to Google",
                  textColor: text,
                  trailing: const Text(
                    "Connected",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Google account settings coming soon")),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, size: 26, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: textColor.withOpacity(0.7),
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }


  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 0.6,
        color: Colors.grey.withOpacity(0.4),
      ),
    );
  }
}
