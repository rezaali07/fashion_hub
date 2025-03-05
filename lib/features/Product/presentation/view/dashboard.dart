// import 'package:fashion_hub/app/di/di.dart';
// import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
// import 'package:fashion_hub/features/Product/domain/use_case/delete_product_usecase.dart';
// import 'package:fashion_hub/features/Product/domain/use_case/get_all_product_usecase.dart';
// import 'package:fashion_hub/features/Product/domain/use_case/upload_image_usecase.dart';
// import 'package:fashion_hub/features/product/presentation/view_model/bloc/product_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'dart:math';
// import 'product_card.dart';

// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductBloc(
//         getAllProductUseCase: getIt<GetAllProductUseCase>(),
//         deleteProductUsecase: getIt<DeleteProductUsecase>(),
//         uploadProductImageUsecase: getIt<UploadProductImageUsecase>(),
//       )..add(GetAllProduct()),
//       child: const DashboardViewContent(),
//     );
//   }
// }

// class DashboardViewContent extends StatefulWidget {
//   const DashboardViewContent({super.key});

//   @override
//   _DashboardViewContentState createState() => _DashboardViewContentState();
// }

// class _DashboardViewContentState extends State<DashboardViewContent>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController searchController = TextEditingController();
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     searchController.addListener(() {
//       setState(() {});
//     });
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white, // White background
//         elevation: 0.5, // Light shadow
//         title: _buildSearchField(), // Search field in the AppBar
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(kToolbarHeight),
//           child: Container(
//             color: Colors.white, // Background color for tab bar
//             child: TabBar(
//               controller: _tabController,
//               indicatorColor: Colors.orange, // Orange indicator
//               labelColor: Colors.orange,
//               labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Increase selected tab text size
//               unselectedLabelStyle: const TextStyle(fontSize: 20), // Orange for selected tab
//               unselectedLabelColor: const Color.fromARGB(255, 40, 39, 39), // Grey for unselected tab
//               tabs: const [
//                 Tab(text: 'Best Sell'),
//                 Tab(text: 'For You'),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: BlocBuilder<ProductBloc, ProductState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state.product.isEmpty) {
//               return const Center(child: Text("No products available"));
//             }

//             final filteredProducts = state.product.where((product) {
//               return product.name
//                   .toLowerCase()
//                   .contains(searchController.text.toLowerCase());
//             }).toList();

//             return Column(
//               children: [
//                 _buildCarousel(), // Carousel below the AppBar
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       // Best Sell Page
//                       _buildProductGrid(filteredProducts),

//                       // For You Page (Random Products)
//                       _buildProductGrid(_getRandomProducts(filteredProducts)),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return TextField(
//       controller: searchController,
//       decoration: InputDecoration(
//         hintText: "Search products...",
//         prefixIcon: const Icon(Icons.search, color: Colors.grey),
//         filled: true,
//         fillColor: Colors.grey[200],
//         contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _buildProductGrid(List<ProductEntity> products) {
//     return GridView.builder(
//       itemCount: products.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.7,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemBuilder: (context, index) {
//         final product = products[index];

//         return ProductCard(product: product); // Use the ProductCard widget
//       },
//     );
//   }

//   // Carousel widget using local assets
//   Widget _buildCarousel() {
//     return CarouselSlider(
//       items: [
//         Image.asset(
//           'assets/carousel_img/image1.png',
//           fit: BoxFit.cover,
//         ),
//         Image.asset(
//           'assets/carousel_img/image2.png',
//           fit: BoxFit.cover,
//         ),
//         // Add more images if needed
//       ],
//       options: CarouselOptions(
//         autoPlay: true,
//         enlargeCenterPage: true,
//         aspectRatio: 2.0,
//         viewportFraction: 1.0,
//         enlargeStrategy: CenterPageEnlargeStrategy.height,
//       ),
//     );
//   }

//   // Get random products for "For You" section
//   List<ProductEntity> _getRandomProducts(List<ProductEntity> products) {
//     final random = Random();
//     return List.generate(
//       5, // Number of random products
//       (index) => products[random.nextInt(products.length)],
//     );
//   }
// }


import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/domain/use_case/delete_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/upload_image_usecase.dart';
import 'package:fashion_hub/features/product/presentation/view_model/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';
import 'product_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        getAllProductUseCase: getIt<GetAllProductUseCase>(),
        deleteProductUsecase: getIt<DeleteProductUsecase>(),
        uploadProductImageUsecase: getIt<UploadProductImageUsecase>(),
      )..add(GetAllProduct()),
      child: const DashboardViewContent(),
    );
  }
}

class DashboardViewContent extends StatefulWidget {
  const DashboardViewContent({super.key});

  @override
  _DashboardViewContentState createState() => _DashboardViewContentState();
}

class _DashboardViewContentState extends State<DashboardViewContent>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: _buildSearchField(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              labelColor: Colors.orange,
              labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontSize: 20),
              unselectedLabelColor: const Color.fromARGB(255, 40, 39, 39),
              tabs: const [
                Tab(text: 'Best Sell'),
                Tab(text: 'For You'),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.product.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            final filteredProducts = state.product.where((product) {
              return product.name
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase());
            }).toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildCarousel()), // Carousel is now scrollable
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10),
                  sliver: SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProductGrid(filteredProducts),
                        _buildProductGrid(_getRandomProducts(filteredProducts)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search products...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<ProductEntity> products) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Prevents independent scrolling
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      items: [
        Image.asset('assets/carousel_img/image.png', fit: BoxFit.cover),
        Image.asset('assets/carousel_img/image2.png', fit: BoxFit.cover),
        Image.asset('assets/carousel_img/image1.png', fit: BoxFit.cover),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        scrollPhysics: const NeverScrollableScrollPhysics(), // Prevents carousel-only scrolling
      ),
    );
  }

  List<ProductEntity> _getRandomProducts(List<ProductEntity> products) {
    final random = Random();
    return List.generate(
      5,
      (index) => products[random.nextInt(products.length)],
    );
  }
}

