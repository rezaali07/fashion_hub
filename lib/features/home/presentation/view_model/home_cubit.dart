import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_hub/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  // Handle logout
  void logout() {
    emit(HomeState.initial());
  }
}
