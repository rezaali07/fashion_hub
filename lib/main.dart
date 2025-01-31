import 'package:fashion_hub/app/app.dart';
import 'package:fashion_hub/app/di/di.dart';
import 'package:flutter/cupertino.dart';

import 'core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Database
  await HiveService().init();

  await initDependencies();
  runApp(
    App(),
  );
}

// First create Entity => Model => Repository
