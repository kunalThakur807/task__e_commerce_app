import 'package:app_task/utils/constants/constants.dart';
import 'package:app_task/utils/services/credentials_storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      CredentialsStorage
          .checkLoginStatus(); // Redirects based on stored credentials
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: const CircularProgressIndicator(color: purpleColor),
      ),
    );
  }
}
