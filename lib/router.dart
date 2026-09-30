import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shopwave/features/auth/auth_provider.dart';
import 'package:shopwave/features/auth/auth_state.dart';
import 'package:shopwave/features/auth/login_screen.dart';

// routes that don't require authentication
final _publicRoutes = ['/login'];

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = _AuthChangeNotifier(ref);
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isPublicRoute = _publicRoutes.contains(state.matchedLocation);

      if (authState is AuthStateInitial) return null;

      if (authState is AuthStateAuthenticated) {
        return isPublicRoute ? null : '/login';
      }

      // TODO: Redirect to product in the future stage
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ],
  );
});

class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      notifyListeners();
    });
  }
}
