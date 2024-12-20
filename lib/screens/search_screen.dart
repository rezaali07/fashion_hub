// lib/screens/home_page.dart
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = ''; // Variable to store the search input

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    // Here you can perform a search or filter your data based on _searchQuery
    print('Searching for: $_searchQuery');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your Product Name',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged:
                  _onSearchChanged, // Listen to changes in the search bar
              decoration: const InputDecoration(
                labelText: 'Search Product', // Label for the search bar
                hintText: 'Type product name...', // Hint text when empty
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon:
                    Icon(Icons.search), // Search icon inside the input field
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
