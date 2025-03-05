import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/domain/use_case/delete_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/upload_image_usecase.dart';
import 'package:fashion_hub/features/product/presentation/view_model/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_card.dart'; // Import the new product card file

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        getAllProductUseCase: getIt<GetAllProductUseCase>(),
        deleteProductUsecase: getIt<DeleteProductUsecase>(),
        uploadProductImageUsecase: getIt<UploadProductImageUsecase>(),
      )..add(GetAllProduct()),
      child: const ProductsViewContent(),
    );
  }
}

class ProductsViewContent extends StatefulWidget {
  const ProductsViewContent({super.key});

  @override
  _ProductsViewContentState createState() => _ProductsViewContentState();
}

class _ProductsViewContentState extends State<ProductsViewContent> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
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

            return Column(
              children: [
                _buildSearchField(),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredProducts.isEmpty
                      ? const Center(child: Text("No products found"))
                      : _buildProductGrid(filteredProducts),
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
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<ProductEntity> products) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(product: product); // Use the ProductCard widget
      },
    );
  }
}
