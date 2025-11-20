import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String name = "Mr. Wahyu";
  String email = "whyuravi.2008@gmail.com";
  String phone = "085624403664";
  String? photoPath; 
  
  final String defaultAssetPhoto = 'Assets/images/wahyuGanteng.jpg'; 

  Future<void> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? name;
    email = prefs.getString('email') ?? email;
    phone = prefs.getString('phone') ?? phone;
    photoPath = prefs.getString('photoPath'); 
    notifyListeners();
  }
  
  Future<void> updateProfile(String newName, String newEmail, String newPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = newName;
    email = newEmail;
    phone = newPhone;

    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);

    notifyListeners();
  }

  Future<void> updatePhoto(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    photoPath = path;
    await prefs.setString('photoPath', photoPath!);
    notifyListeners();
  }
}