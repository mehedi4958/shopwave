import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: ShopWaveApp()));
}

class ShopWaveApp extends StatelessWidget {
  const ShopWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopWave',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to ShopWave!'),
        ),
      ),
    );
  }
}
