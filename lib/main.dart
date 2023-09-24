import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/login_api.dart';
import 'package:harmonimo/MyController.dart';
import 'package:harmonimo/landingpage.dart';


void main() {
  Get.put(MyController());
  LoginApi loginApi = LoginApi();
  loginApi.login('춘식몽', '0000');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LandingPage());
  }
}

