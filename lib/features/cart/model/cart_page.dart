import 'dart:convert';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
import 'package:fashion_hub/features/order/data/remote/order_remote_data_source.dart';
import 'package:fashion_hub/features/order/domain/repositories/order_repository.dart';
import 'package:fashion_hub/features/order/presentation/bloc/order_bloc.dart';
import 'package:fashion_hub/features/order/presentation/view/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class CartPage extends StatelessWidget {
  final String apiUrl = "${ApiEndpoints.baseUrl}${ApiEndpoints.createOrder}";
 // Update the correct URL

  // Function to handle order placement
  Future<void> placeOrder(BuildContext context, CartViewModel cartViewModel) async {
    try {
      // Prepare order data to send to the API
      List<Map<String, dynamic>> orderItems = cartViewModel.cartItems.map((item) {
        return {
          "productId": item['product'].id,
          "name": item['product'].name,
          "price": (item['product'].price as num).toDouble(),  // Ensure price is double
          "image": item['product'].imageUrl,
          "quantity": item['quantity'],
        };
      }).toList();

      // Create the request body
      Map<String, dynamic> orderData = {
        "shippingInfo": {
          "address": "jnk", // Replace with user input
          "phone": "1234567890", // Replace with user input
        },
        "orderItems": orderItems,
        "paymentInfo": {
          "status": "Cash on Delivery", // Replace with selected payment method
        },
        "itemsPrice": (cartViewModel.totalPrice as num).toDouble(), // Ensure it's double
        "taxPrice": 10.0, // Explicitly double
        "shippingPrice": 5.0, // Explicitly double
        "totalPrice": ((cartViewModel.totalPrice as num).toDouble() + 10.0 + 5.0), // Ensure calculation is double
      };

      // Use Dio for API request
      Dio dio = Dio();
      final response = await dio.post(
        apiUrl,
        data: json.encode(orderData),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer YOUR_AUTH_TOKEN', // Replace with actual token if needed
          },
        ),
      );

      // Check if the request was successful
      if (response.statusCode == 201) {
        // Order placed successfully
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Order placed successfully!'),
          backgroundColor: Colors.green,
        ));

        // Clear the cart after placing the order
        cartViewModel.clearCart();
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to place order! Please try again.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // Handle any exceptions (network error, etc.)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      body: cartViewModel.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartViewModel.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartViewModel.cartItems[index];
                      final product = cartItem['product'];
                      final quantity = cartItem['quantity'];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text("Price: Rs. ${product.price}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => cartViewModel.decreaseQuantity(index),
                              ),
                              Text("$quantity"),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => cartViewModel.increaseQuantity(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => cartViewModel.removeFromCart(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Total: Rs. ${cartViewModel.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          final cartViewModel = Provider.of<CartViewModel>(context, listen: false);

                          final dio = Dio();
                          final orderRemoteDataSource = OrderRemoteDataSource(dio);
                          final orderRepository = OrderRepository(orderRemoteDataSource);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => OrderBloc(orderRepository),
                                child: OrderPage(
                                  remoteDataSource: orderRepository.remoteDataSource,
                                  cartItems: cartViewModel.cartItems.map((item) {
                                    return {
                                      "productId": item['product'].id,
                                      "name": item['product'].name,
                                      "price": (item['product'].price as num).toDouble(), // Ensure price is double
                                      "image": item['product'].imageUrl,
                                      "quantity": item['quantity'],
                                    };
                                  }).toList(),
                                  totalPrice: (cartViewModel.totalPrice as num).toDouble(), // Ensure total price is double
                                ),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
 