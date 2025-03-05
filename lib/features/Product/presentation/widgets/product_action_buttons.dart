// import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
// import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
// import 'package:fashion_hub/features/order/data/remote/order_remote_data_source.dart';
// import 'package:fashion_hub/features/order/domain/repositories/order_repository.dart';
// import 'package:fashion_hub/features/order/presentation/bloc/order_bloc.dart';
// import 'package:fashion_hub/features/order/presentation/view/order_page.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// class ProductActionButtons extends StatelessWidget {
//   final ProductEntity product;
//   final CartViewModel cartViewModel;

//   const ProductActionButtons({
//     super.key,
//     required this.product,
//     required this.cartViewModel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             cartViewModel.addToCart(product);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("${product.name} added to cart!")),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFF6600),
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//             textStyle: const TextStyle(fontSize: 12),
//           ),
//           child: const Text("Add to Cart"),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Navigate to OrderPage with the selected product
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BlocProvider(
//                   create: (context) {
//                     final dio = Dio();
//                     final orderRemoteDataSource = OrderRemoteDataSource(dio);
//                     final orderRepository = OrderRepository(orderRemoteDataSource);
//                     return OrderBloc(orderRepository);
//                   },
//                   child: OrderPage(
//                     remoteDataSource: OrderRemoteDataSource(Dio()),
//                     cartItems: [
//                       {
//                         "productId": product.id,
//                         "name": product.name,
//                         "price": (product.price as num).toDouble(), // Ensure price is double
//                         "image": product.imageUrl,
//                         "quantity": 1, // Buy Now is always 1 quantity
//                       }
//                     ],
//                     totalPrice: (product.price as num).toDouble(), // Ensure total price is double
//                   ),
//                 ),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFF6600),
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//             textStyle: const TextStyle(fontSize: 12),
//           ),
//           child: const Text("Buy Now"),
//         ),
//       ],
//     );
//   }
// }

import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
import 'package:fashion_hub/features/order/data/remote/order_remote_data_source.dart';
import 'package:fashion_hub/features/order/domain/repositories/order_repository.dart';
import 'package:fashion_hub/features/order/presentation/bloc/order_bloc.dart';
import 'package:fashion_hub/features/order/presentation/view/order_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProductActionButtons extends StatelessWidget {
  final ProductEntity product;
  final CartViewModel cartViewModel;

  const ProductActionButtons({
    super.key,
    required this.product,
    required this.cartViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 30, // Ensures both buttons have the same height
            child: ElevatedButton(
              onPressed: () {
                cartViewModel.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product.name} added to cart!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
              child: const Text("Cart"),
            ),
          ),
        ),
        const SizedBox(width: 5), // Space between buttons
        Expanded(
          child: SizedBox(
            height: 30, // Ensures both buttons have the same height
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) {
                        final dio = Dio();
                        final orderRemoteDataSource = OrderRemoteDataSource(dio);
                        final orderRepository = OrderRepository(orderRemoteDataSource);
                        return OrderBloc(orderRepository);
                      },
                      child: OrderPage(
                        remoteDataSource: OrderRemoteDataSource(Dio()),
                        cartItems: [
                          {
                            "productId": product.id,
                            "name": product.name,
                            "price": (product.price as num).toDouble(),
                            "image": product.imageUrl,
                            "quantity": 1,
                          }
                        ],
                        totalPrice: (product.price as num).toDouble(),
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
              child: const Text("Buy Now"),
            ),
          ),
        ),
      ],
    );
  }
}
