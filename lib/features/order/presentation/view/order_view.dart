import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "This is the Order page",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
