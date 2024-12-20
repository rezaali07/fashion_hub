import 'package:fashion_hub/screens/forgot_password_screen.dart';
import 'package:fashion_hub/screens/home_screen.dart';
import 'package:fashion_hub/screens/login_screen.dart';
import 'package:fashion_hub/screens/onboarding_screen.dart';
import 'package:fashion_hub/screens/register_screen.dart';
import 'package:fashion_hub/screens/splash_screen.dart';

class AppRoute {
  AppRoute._();

  static const String splashScreen = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String login = '/login';

  static getAppRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      onboarding: (contex) => const OnboardingScreen(),
      login: (context) => const LoginScreen(),
      home: (context) => const HomeScreen(),
      register: (context) => const RegisterScreen(),
      forgetPassword: (context) => const ForgotPasswordScreen()
    };
  }
}
