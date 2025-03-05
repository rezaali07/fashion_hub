import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/cart/view_model/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class ShakeToCart extends StatefulWidget {
  final ProductEntity product;

  const ShakeToCart({super.key, required this.product});

  @override
  _ShakeToCartState createState() => _ShakeToCartState();
}

class _ShakeToCartState extends State<ShakeToCart> {
  double _previousX = 0.0, _previousY = 0.0, _previousZ = 0.0;
  double _threshold = 15.0; // Shake detection sensitivity

  @override
  void initState() {
    super.initState();
    // Listen to accelerometer events to detect shake
    accelerometerEvents.listen((AccelerometerEvent event) {
      _detectShake(event);
    });
  }

  // Detect shake by comparing changes in accelerometer data
  void _detectShake(AccelerometerEvent event) {
    double x = event.x;
    double y = event.y;
    double z = event.z;

    // Calculate the movement difference
    double deltaX = (x - _previousX).abs();
    double deltaY = (y - _previousY).abs();
    double deltaZ = (z - _previousZ).abs();

    // If the difference exceeds the threshold, shake detected
    if (deltaX > _threshold || deltaY > _threshold || deltaZ > _threshold) {
      _addToCart();
    }

    // Update previous values for next comparison
    _previousX = x;
    _previousY = y;
    _previousZ = z;
  }

  // Function to add product to cart
  void _addToCart() {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    cartViewModel.addToCart(widget.product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // This widget does not need any UI, it just listens to shake events
  }
}
