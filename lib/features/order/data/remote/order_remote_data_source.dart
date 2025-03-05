import 'package:dio/dio.dart';

class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  // Send order data with token in the Cookie header
  Future<void> placeOrder(Map<String, dynamic> orderData, String token) async {
    try {
      final response = await dio.post(
        "http://10.0.2.2:4000/api/v2/order/new",  // The backend API URL
        data: orderData,  // Pass the order data as JSON
        options: Options(
          headers: {
            'Content-Type': 'application/json',  // Ensure correct content type
            'Cookie': 'token=$token',  // Set the token as a cookie
          },
        ),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      print('Error placing order: $e');
      throw Exception("Error placing the order: ${e.toString()}");
    }
  }
}
