import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';
import 'package:fashion_hub/features/auth/presentation/view/login_view.dart';
import 'package:fashion_hub/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:fashion_hub/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final IUserRepository authRepository;

  HomeCubit({required this.authRepository}) : super(HomeState.initial());

  /// Handle bottom navigation tab changes
  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  /// Logout user and navigate to login screen
  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
