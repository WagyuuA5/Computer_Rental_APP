// lib/screens/account_info_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/profile_provider.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Account info'),
        centerTitle: true,
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: textColor),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [

          ListTile(
            title: Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            subtitle: Text(
              profile.email,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            trailing: Text(
              'Verified',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Divider(height: 1, thickness: 1),

          ListTile(
            title: Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Change password feature coming soon'),
                ),
              );
            },
          ),

          const Divider(height: 1, thickness: 1),

          ListTile(
            title: Text(
              'Account details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/info-account');
            },
          ),

          const Divider(height: 1, thickness: 1),

          ListTile(
            title: Text(
              'Mobile phone',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            trailing: Text(
              'Not verified',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Phone verification coming soon'),
                ),
              );
            },
          ),

          const Divider(height: 1, thickness: 1),

          ListTile(
            title: Text(
              'Google',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            trailing: Text(
              'Connected',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google account settings coming soon'),
                ),
              );
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
