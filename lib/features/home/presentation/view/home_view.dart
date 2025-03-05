import 'package:fashion_hub/core/common/snackbar/my_snackbar.dart';
import 'package:fashion_hub/features/home/presentation/view_model/home_cubit.dart';
import 'package:fashion_hub/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isDarkMode = state.isDarkMode; // Assuming you add this in your state

        return Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ],
            ),
            backgroundColor: isDarkMode ? Colors.grey[800] : Color(0xFFFF6600),
            actions: [
              // Slider Button to Toggle Dark Mode
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  context.read<HomeCubit>().toggleDarkMode(); // Call the function to toggle dark mode
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  showMySnackBar(
                    context: context,
                    message: 'Logging out...',
                    color: Colors.red,
                  );
                  context.read<HomeCubit>().logout(context);
                },
              ),
            ],
          ),
          body: Container(
            color: isDarkMode ? Colors.black : Colors.white, // Change screen color
            child: state.views.elementAt(state.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Color(0xFFFF6600),
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xFFFF6600),
                icon: Icon(Icons.storefront),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xFFFF6600),
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xFFFF6600),
                icon: Icon(Icons.card_travel),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xFFFF6600),
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
            backgroundColor: isDarkMode ? Colors.grey[900] : Color(0xFFFF6600), // Change bottom navbar color
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          ),
        );
      },
    );
  }
}

