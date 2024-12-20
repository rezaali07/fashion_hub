import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayText = "Welcome to the Home Screen!";

  void _updateText() {
    setState(() {
      displayText = "Text has been updated!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(displayText),
            ElevatedButton(
              onPressed: _updateText,
              child: const Text('Update Text'),
            ),
          ],
        ),
      ),
    );
  }
}
