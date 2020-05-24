import 'package:GroceryApp/src/myapp.dart';
import 'package:GroceryApp/src/routes/router.dart';
import 'package:GroceryApp/src/services/internetconnectivity.dart';
import 'package:flutter/material.dart';

void main() {
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  FluroRouter.setupRouter();
  runApp(MyApp());
}