import 'package:app_task/views/auth/views/login_screen.dart';
import 'package:app_task/views/home/views/home_screen.dart';
import 'package:app_task/views/onbording/views/onbording_screnn.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CredentialsStorage {
  static final GetStorage _storage = GetStorage();

  static void saveCredentials(String email, String password) {
    _storage.write('email', email);
    _storage.write('password', password);
    Get.offAll(() => const HomeScreen());
  }

  static bool hasCredentials() {
    return _storage.hasData('email') && _storage.hasData('password');
  }

  static void checkLoginStatus() {
    if (hasCredentials()) {
      Get.offAll(
          () => const HomeScreen()); // Navigate to Home if credentials exist
    } else {
      Get.offAll(
          () => const OnBordingScreen()); // Navigate to Login if no credentials
    }
  }

  static void clearCredentials() {
    _storage.remove('email');
    _storage.remove('password');
  }
}
