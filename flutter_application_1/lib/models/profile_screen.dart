

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryColor = isDarkMode ? Colors.white70 : Colors.grey;

    ImageProvider? profileImageProvider;

    if (profile.photoPath != null) {
      profileImageProvider = FileImage(File(profile.photoPath!));
    } else if (profile.defaultAssetPhoto.isNotEmpty) {
      profileImageProvider = AssetImage(profile.defaultAssetPhoto);
    } 

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Account'),
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
          Container(
            padding: const EdgeInsets.all(20),
            color: bgColor,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                  backgroundImage: profile.photoPath != null
                      ? FileImage(File(profile.photoPath!))
                      :AssetImage('Assets/images/wahyuGanteng.jpg'),
                  child: null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name.isEmpty ? 'User' : profile.name,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _showEditDialog(context),
                        child: Text(
                          'View and edit profile',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          const Divider(height: 1, thickness: 1),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: 'Account info',
            onTap: () => Navigator.pushNamed(context, '/account-info')
          ),
          // _buildMenuItem(context,
          //  icon: Icons.person_outline,
          //  title: 'Info Account',
          //  onTap: () => Navigator.pushNamed(context, '/info-account'),
          // ),
          _buildMenuItem(
            context,
            icon: Icons.lightbulb_outline,
            title: 'Ask V',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'New',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          _buildMenuItem(
            context,
            icon: Icons.card_giftcard,
            title: 'Gift cards',
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'Why choose V-Com?',
          ),
          _buildMenuItem(
            context,
            icon: Icons.support_agent,
            title: 'Contact Support',
          ),
          _buildMenuItem(
            context,
            icon: Icons.description,
            title: 'Legal',
          ),

          const Divider(height: 1, thickness: 1),

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blue,
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

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, Widget? trailing, VoidCallback? onTap}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return ListTile(
      leading: Icon(
        icon,
        color: isDarkMode ? Colors.white70 : Colors.grey,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );
  }

  void _showEditDialog(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context, listen: false);

    final nameController = TextEditingController(text: profile.name);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Edit Profile'),
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  textCapitalization: TextCapitalization.words,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final phone = phoneController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Name cannot be empty')),
                  );
                  return;
                }

                profile.updateProfile(name, email, phone);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

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
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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