import 'package:equatable/equatable.dart';
import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/features/Product/presentation/view/dashboard.dart';
import 'package:fashion_hub/features/Product/presentation/view/products_view.dart';
import 'package:fashion_hub/features/Product/presentation/view_model/bloc/product_bloc.dart';
import 'package:fashion_hub/features/auth/presentation/view/edit_profile_page.dart';
import 'package:fashion_hub/features/cart/model/cart_page.dart';
import 'package:fashion_hub/features/order/presentation/view/my_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;
  final bool isDarkMode; // Added dark mode state

  const HomeState({
    required this.selectedIndex,
    required this.views,
    required this.isDarkMode,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      isDarkMode: false, // Default light mode
      views: [
        DashboardView(),
        BlocProvider(
          create: (context) => getIt<ProductBloc>(),
          child: const ProductsView(),
        ),
        CartPage(),
        MyOrdersPage(),
        EditProfilePage(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
    bool? isDarkMode,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views, isDarkMode];
}

