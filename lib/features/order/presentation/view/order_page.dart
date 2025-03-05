import 'package:fashion_hub/features/order/data/remote/order_remote_data_source.dart';
import 'package:fashion_hub/features/order/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderPage extends StatefulWidget {
  final OrderRemoteDataSource remoteDataSource;
  final List<Map<String, dynamic>> cartItems; // Receive cart items
  final double totalPrice;

  OrderPage({required this.remoteDataSource, required this.cartItems, required this.totalPrice});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(labelText: 'Postal Code'),
              ),
              TextField(
                controller: phoneNoController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              
              // Display Order Summary
              Text("Total Price: Rs. ${widget.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  String? token = await getToken();
                  if (token != null) {
                    try {
                      final order = OrderEntity(
                        shippingInfo: ShippingInfo(
                          address: addressController.text,
                          city: cityController.text,
                          postalCode: postalCodeController.text,
                          country: "Nepal", // Set country by default
                          phoneNo: phoneNoController.text,
                        ),
                        orderItems: widget.cartItems.map((item) {
                          return OrderItem(
                            product: item['productId'],
                            name: item['name'],
                            price: item['price'],
                            quantity: item['quantity'],
                            image: item['image'],
                          );
                        }).toList(),
                        paymentInfo: PaymentInfo(
                          id: "COD",
                          status: "Cash on Delivery",
                        ),
                        itemsPrice: widget.totalPrice,
                        taxPrice: 10.0,
                        shippingPrice: 5.0,
                        totalPrice: widget.totalPrice + 10.0 + 5.0,
                      );

                      // Send the order request
                      await widget.remoteDataSource.placeOrder(order.toJson(), token);

                      // Success message
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully!')));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error placing the order: $e')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Token is missing. Please log in again.')));
                  }
                },
                child: const Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
