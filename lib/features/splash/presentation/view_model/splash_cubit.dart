import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/features/onboarding_screen/presentation/view/onboarding_view.dart';
import 'package:fashion_hub/features/onboarding_screen/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  // final LoginBloc _loginBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Open Login page or Onboarding Screen

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<OnboardingCubit>(),
              child: OnboardingView(),
            ),
          ),
        );
      }
    });
  }
}
