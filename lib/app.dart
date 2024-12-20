// app.dart
import 'package:fashion_hub/core/app_theme/app_theme.dart';
import 'package:fashion_hub/screens/forgot_password_screen.dart';
import 'package:fashion_hub/screens/home_screen.dart';
import 'package:fashion_hub/screens/login_screen.dart';
import 'package:fashion_hub/screens/onboarding_screen.dart';
import 'package:fashion_hub/screens/register_screen.dart';
import 'package:fashion_hub/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/forgetPassword': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
