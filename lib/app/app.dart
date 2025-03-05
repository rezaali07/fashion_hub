import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/core/theme/app_theme.dart';
import 'package:fashion_hub/features/splash/presentation/view/splash_view.dart';
import 'package:fashion_hub/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartViewModel()), // ✅ Corrected placement
        BlocProvider.value(value: getIt<SplashCubit>()), // ✅ Corrected placement
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fashion Hub',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const SplashView(),
      ),
    );
  }
}
