import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items
  List<Map<String, dynamic>> cartItems = [
    {"name": "Product 1", "price": 20.0},
    {"name": "Product 2", "price": 15.0},
    {"name": "Product 3", "price": 30.0},
  ];

  // Function to remove an item from the cart
  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(item["name"]),
                    subtitle: Text("\$${item["price"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeItem(index), // Remove the item
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Logic for checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to checkout...')),
                  );
                },
                child: const Text("Checkout"),
              ),
            )
          : null, // No checkout button if the cart is empty
    );
  }
}
