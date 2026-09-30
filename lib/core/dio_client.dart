import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopwave/features/auth/auth_provider.dart';
import 'package:shopwave/features/auth/auth_state.dart';

import 'constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true, error: true),
  );

  return dio;
});

final authenticatedDioProvider = Provider<Dio>((ref) {
  final authState = ref.watch(authProvider);
  final dio = ref.watch(dioProvider);

  final token = authState is AuthStateAuthenticated
      ? authState.user.token
      : null;

  if (token != null) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  } else {
    dio.options.headers.remove('Authorization');
  }
  return dio;
});
