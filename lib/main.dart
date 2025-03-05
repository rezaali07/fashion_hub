import 'package:fashion_hub/app/app.dart';
import 'package:fashion_hub/app/di/di.dart';
import 'package:fashion_hub/core/network/hive_service.dart';
import 'package:fashion_hub/features/Product/data/model/product_hive_model.dart';
import 'package:fashion_hub/features/order/data/model/order_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Register Hive adapters
  Hive.registerAdapter(ProductHiveModelAdapter());
  Hive.registerAdapter(OrderHiveModelAdapter());

  // Initialize Hive Database
  await HiveService().init();

  // Initialize Dependencies (Dependency Injection)
  await initDependencies();

  // Run the main application
  runApp(App());
}
