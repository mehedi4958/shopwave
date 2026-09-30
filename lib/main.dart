import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopwave/router.dart';

void main() {
  runApp(ProviderScope(child: ShopWaveApp()));
}

class ShopWaveApp extends ConsumerWidget {
  const ShopWaveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ShopWave',
      theme: ThemeData(primaryColor: Colors.blue),
      routerConfig: router,
    );
  }
}
