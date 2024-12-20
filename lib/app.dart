// app.dart
import 'package:fashion_hub/core/app_theme/app_theme.dart';
import 'package:fashion_hub/routes/app_route.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: AppRoute.splashScreen,
      routes: AppRoute.getAppRoutes(),
    );
  }
}
