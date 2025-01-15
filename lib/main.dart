import 'package:flutter/material.dart';
import 'package:gaengdo/view/Screen/Home.dart';
import 'package:gaengdo/view/Screen/Splash.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: Splash(),);
  }
}