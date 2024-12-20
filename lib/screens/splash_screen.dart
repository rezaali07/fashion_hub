import 'dart:async';

import 'package:fashion_hub/utils/colors.dart';
import 'package:fashion_hub/utils/image_paths.dart'; // Ensure this is the file containing `AppImagePath` and `LogoPath`
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.kPrimary, AppColor.kBackGroundColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Use the logo path from the LogoPath class
              Image.asset(
                LogoPath.kRectangleBackgound, // Path to your logo
                width: 150, // Adjust size as needed
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Fashion Hub',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kText, // Ensure this color exists in AppColor
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.kText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
