import 'package:fashion_hub/app/constants/hive_table_constant.dart';
import 'package:fashion_hub/features/Product/data/model/product_hive_model.dart';
import 'package:fashion_hub/features/order/data/model/order_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/data/model/user_hive_model.dart';

class HiveService {
  Future<void> init() async {
    //Initialize the Database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}softwarica_user_management.db';
    //Create Database
    Hive.init(path);
    //Register Adapters

    Hive.registerAdapter(UserHiveModelAdapter());
  }

// user Queries
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    return users;
  }

  Future<UserHiveModel?> loginUser(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);

    var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => UserHiveModel.initial());

    return auth;
  }

  //
  //Product Queries
  Future<void> addProduct(ProductHiveModel product) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.put(product.id, product);
  }

  // Update Product Query
  Future<void> updateProduct(ProductHiveModel product) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.put(product.id, product);
  }

  Future<void> deleteProduct(String id) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.delete(id);
  }

  Future<List<ProductHiveModel>> getAllProduct() async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    var products = box.values.toList();
    return products;
  }

  // Order Queries
  Future<void> addOrder(OrderHiveModel order) async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    await box.put(order.orderId, order);
  }

  // Update Order Query
  Future<void> updateOrder(OrderHiveModel order) async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    await box.put(order.orderId, order);
  }

  Future<void> deleteOrder(String id) async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    await box.delete(id);
  }

  Future<List<OrderHiveModel>> getOrder(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('Customer ID cannot be null or empty');
      }

      // Fetching orders for the given customerId from Hive or local database
      final orderBox = await Hive.openBox<OrderHiveModel>('ordersBox');
      final allOrders =
          orderBox.values.where((order) => order.orderId == userId).toList();

      return allOrders; // Return the list of orders for that customer
    } catch (e) {
      // Handle any errors that may occur
      print('Error fetching orders: $e');
      return []; // Return an empty list in case of error
    }
  }
}
