import 'package:crud_api_flutterr/login.dart';
import 'package:crud_api_flutterr/productList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(MainApp());
  // Product
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter RsstAPI',
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
