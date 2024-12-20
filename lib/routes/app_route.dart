import 'package:fashion_hub/screens/dashboard_screen.dart';
import 'package:fashion_hub/screens/forgot_password_screen.dart';
import 'package:fashion_hub/screens/login_screen.dart';
import 'package:fashion_hub/screens/onboarding_screen.dart';
import 'package:fashion_hub/screens/register_screen.dart';
import 'package:fashion_hub/screens/splash_screen.dart';

class AppRoute {
  AppRoute._();

  static const String splashScreen = '/';
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String login = '/login';

  static getAppRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      onboarding: (contex) => const OnboardingScreen(),
      login: (context) => const LoginScreen(),
      dashboard: (context) => const DashboardScreen(),
      register: (context) => const RegisterScreen(),
      forgetPassword: (context) => const ForgotPasswordScreen()
    };
  }
}
