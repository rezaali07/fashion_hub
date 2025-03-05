// import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
// import 'package:fashion_hub/features/Product/presentation/view/product_detail_page.dart';
// import 'package:fashion_hub/features/Product/presentation/widgets/product_action_buttons.dart';
// import 'package:provider/provider.dart';

// class ProductCard extends StatelessWidget {
//   final ProductEntity product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     // Use Provider to get the existing CartViewModel
//     final cartViewModel = Provider.of<CartViewModel>(context, listen: false);

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailPage(product: product),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 4,
//         margin: const EdgeInsets.all(8),
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildProductImage(product.imageUrl),
//               const SizedBox(height: 8),
//               Text(
//                 product.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Rs.${product.price}",
//                 style: const TextStyle(color: Colors.green, fontSize: 14),
//               ),
//               const SizedBox(height: 1),
//               Text(
//                 product.category,
//                 style: const TextStyle(color: Colors.blue, fontSize: 12),
//               ),
//               const SizedBox(height: 10),
//               // Use ProductActionButtons widget here with the correct cartViewModel
//               ProductActionButtons(product: product, cartViewModel: cartViewModel),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductImage(String? imageUrl) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: Image.network(
//         imageUrl ?? 'https://via.placeholder.com/150',
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) => _placeholderImage(),
//       ),
//     );
//   }

//   Widget _placeholderImage() {
//     return Container(
//       color: Colors.grey,
//       child: const Center(
//           child: Icon(Icons.image_not_supported, size: 50, color: Colors.white)),
//     );
//   }
// }


import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/presentation/view/product_detail_page.dart';
import 'package:fashion_hub/features/Product/presentation/widgets/product_action_buttons.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxWidth * 0.8;
        double textSize = constraints.maxWidth * 0.05;
        double priceSize = constraints.maxWidth * 0.04;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductImage(product.imageUrl, imageSize),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textSize.clamp(20, 20)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Rs.${product.price}",
                    style: TextStyle(
                        color: Colors.green, fontSize: priceSize.clamp(15, 15)),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    product.category,
                    style: TextStyle(
                        color: Colors.blue, fontSize: priceSize.clamp(12, 12)),
                  ),
                  const SizedBox(height: 10),
                  ProductActionButtons(
                      product: product, cartViewModel: cartViewModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductImage(String? imageUrl, double size) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Image.network(
        imageUrl ?? 'https://via.placeholder.com/150',
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => _placeholderImage(size),
      ),
    );
  }

  Widget _placeholderImage(double size) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey,
      child: const Center(
          child: Icon(Icons.image_not_supported, size: 50, color: Colors.white)),
    );
  }
}
