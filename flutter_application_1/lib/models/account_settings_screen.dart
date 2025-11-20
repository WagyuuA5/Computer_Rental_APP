// lib/Screens/account_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/profile_provider.dart'; 


class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final profile = Provider.of<ProfileProvider>(context); //  Access provider 

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text(
              "Account info",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              "Email, phone & password",
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/account-info');
            },
          ),

          const Divider(),
          ListTile(
            title: const Text('Notification settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification settings coming soon')),
              );
            },
          ),

          const Divider(height: 1, thickness: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rental credit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  'Rp 0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: Text(
              'Redeem gift card',
              style: TextStyle(color: AppColors.primary),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Redeem gift card feature coming soon')),
              );
            },
          ),

          ListTile(
            title: Text(
              'Add rental credit',
              style: TextStyle(color: AppColors.primary),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add credit feature coming soon')),
              );
            },
          ),

          const Divider(height: 1, thickness: 1),

          ListTile(
            title: const Text('Manual transmission'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Manual payment method coming soon')),
              );
            },
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Log out', style: TextStyle(fontSize: 16)),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: TextButton(
              onPressed: () => _showCloseAccountDialog(context),
              child: Text(
                'Close my account',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // void _showEditDialog(BuildContext context, ProfileProvider profile) {
  //   final nameController = TextEditingController(text: profile.name);
  //   final emailController = TextEditingController(text: profile.email);
  //   final phoneController = TextEditingController(text: profile.phone);

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //         title: const Text('Edit Profile'),
  //         content: SizedBox(
  //           width: double.infinity,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(labelText: 'Full Name'),
  //                 textCapitalization: TextCapitalization.words,
  //               ),
  //               TextField(
  //                 controller: emailController,
  //                 decoration: const InputDecoration(labelText: 'Email'),
  //                 keyboardType: TextInputType.emailAddress,
  //               ),
  //               TextField(
  //                 controller: phoneController,
  //                 decoration: const InputDecoration(labelText: 'Phone Number'),
  //                 keyboardType: TextInputType.phone,
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Cancel'),
  //           ),
  //           FilledButton(
  //             onPressed: () {
  //               final name = nameController.text.trim();
  //               final email = emailController.text.trim();
  //               final phone = phoneController.text.trim();

  //               if (name.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text('Name cannot be empty')),
  //                 );
  //                 return;
  //               }

  //               profile.updateProfile(name, email, phone);

  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Log Out?'),
        content: const Text('Are you sure you want to log out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showCloseAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Close My Account?'),
        content: const Text(
          'Closing your account will permanently delete all your data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account closure request submitted')),
              );
            },
            child: const Text('Close Account', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}