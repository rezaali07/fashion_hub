import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  // Getter to access the cart items
  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Getter to calculate the total price of all items in the cart
  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item['product'].price * item['quantity']));
  }

  // Method to add an item to the cart
  void addToCart(ProductEntity product) {
    int index = _cartItems.indexWhere((item) => item['product'].id == product.id);
    if (index != -1) {
      _cartItems[index]['quantity'] += 1;  // Increase quantity if the product is already in the cart
    } else {
      _cartItems.add({'product': product, 'quantity': 1});  // Add new product to the cart
    }
    notifyListeners();
  }

  // Method to increase the quantity of an item in the cart
  void increaseQuantity(int index) {
    _cartItems[index]['quantity'] += 1;
    notifyListeners();
  }

  // Method to decrease the quantity of an item in the cart
  void decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity'] -= 1;
    } else {
      _cartItems.removeAt(index);  // Remove the item from the cart if quantity is 1
    }
    notifyListeners();
  }

  // Method to remove an item from the cart
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Method to clear all items from the cart
  void clearCart() {
    _cartItems.clear();  // Clears all items in the cart
    notifyListeners();    // Notify listeners to update UI after clearing the cart
  }
}
