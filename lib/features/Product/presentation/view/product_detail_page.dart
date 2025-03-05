import 'package:fashion_hub/core/common/shake_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
import 'package:fashion_hub/features/Product/presentation/widgets/product_action_buttons.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? "Product Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: _buildProductImage(product.imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              product.name ?? "Unknown Product",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: Rs.${product.price ?? 'N/A'}",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              product.category ?? "Uncategorized",
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            ProductActionButtons(product: product, cartViewModel: cartViewModel),

            // Integrate ShakeToCart widget for shake-to-add-to-cart functionality
            ShakeToCart(product: product),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? imageUrl) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Image.network(
        imageUrl ?? 'https://via.placeholder.com/150',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholderImage(),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: Colors.grey,
      child: const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.white)),
    );
  }
}
