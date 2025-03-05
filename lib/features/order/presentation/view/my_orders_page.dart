import 'package:dio/dio.dart';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final String apiUrl = "${ApiEndpoints.baseUrl}${ApiEndpoints.getUserOrder}"; // Use localhost if needed
  List<dynamic> orders = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      String? token = await getToken();

      if (token == null) {
        handleSessionExpired();
        return;
      }

      print("🔑 Retrieved Token: $token"); // Debugging

      Dio dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Cookie': 'token=$token', // Some APIs require cookies
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          orders = response.data['orders'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load orders. Status Code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await clearToken(); // Remove expired token
        handleSessionExpired();
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "Error fetching orders: ${e.response?.statusCode ?? 'Unknown'}";
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching orders: ${e.message}"), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "An unexpected error occurred: $e";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred: $e"), backgroundColor: Colors.red),
      );
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  void handleSessionExpired() {
    setState(() {
      isLoading = false;
      errorMessage = "Session expired. Please log in again.";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Session expired. Redirecting to login..."),
        backgroundColor: Colors.orange,
      ),
    );

    // TODO: Add navigation to login screen if needed
  }

  void showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Shipping Info"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Address: ${order['shippingInfo']['address']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Phone: ${order['shippingInfo']['phoneNo']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Payment: ${order['paymentInfo']['status']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)))
              : orders.isEmpty
                  ? const Center(child: Text("No orders found"))
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            title: Text("Order ID: ${order['_id']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Total Price: Rs. ${order['totalPrice']}"),
                            trailing: ElevatedButton(
                              onPressed: () => showOrderDetails(context, order),
                              child: const Text("Details"),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
