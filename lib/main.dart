import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/screens/view/loginScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const LoginScreens(),
    },
  ));
}
