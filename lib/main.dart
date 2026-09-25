import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopwave/features/home/home_screen.dart';

void main() {
  runApp(ProviderScope(child: ShopWaveApp()));
}

class ShopWaveApp extends StatelessWidget {
  const ShopWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopWave',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
