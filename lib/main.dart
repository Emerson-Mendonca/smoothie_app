import 'package:flutter/material.dart';
import 'package:smoothie_app/modules/home/presenter/page/home_page.dart';
import 'package:smoothie_app/modules/home/presenter/stores/home_page_store.dart';

void main() {
  runApp(const SmoothieApp());
}

class SmoothieApp extends StatelessWidget {
  const SmoothieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smoothie App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(
        homePageStore: HomePageStore(),
      ),
    );
  }
}
