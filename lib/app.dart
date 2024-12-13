// app.dart
import 'package:fashion_hub/screens/forgot_password_screen.dart';
import 'package:fashion_hub/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fashion_hub/screens/login_screen.dart';
import 'package:fashion_hub/screens/register_screen.dart';
import 'package:fashion_hub/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF4F4F4F), // Use hexadecimal color for consistency
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/forgetPassword': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
