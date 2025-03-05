import 'package:fashion_hub/features/auth/presentation/view/login_view.dart';
import 'package:fashion_hub/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<void> {
  OnboardingCubit(this._loginBloc) : super(null);

  final LoginBloc _loginBloc;

  /// This method handles navigation to the LoginView after the onboarding process is complete
  void navigateToLoginView(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _loginBloc,
            child: LoginView(),
          ),
        ),
      );
    }
  }
}
