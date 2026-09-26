import 'package:shopwave/features/auth/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopwave/core/constants.dart';
import 'package:shopwave/core/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shopwave/models/user.dart';

import 'dart:convert';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _restoreSession();
    return const AuthStateInitial();
  }

  Future<void> _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString(AppConstants.authTokenKey);

    if (savedToken == null) return;

    try {
      final dio = ref.read(dioProvider);
      final response = await dio.get(
        AppConstants.profileRoute,
        options: Options(headers: {'Authorization': 'Bearer $savedToken'}),
      );
      final user = User.fromJson(response.data['user'] as Map<String, dynamic>);
      state = AuthStateAuthenticated(user);
    } catch (_) {}
  }

  Future<void> login(String email, String password) async {
    state = const AuthStateLoading();

    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        AppConstants.loginRoute,
        data: {'email': email, 'password': password},
      );
      final user = User.fromJson(response.data['user'] as Map<String, dynamic>);
      state = AuthStateAuthenticated(user);
    } on DioException catch (e) {
      final message =
          (e.response?.data['message'] as Map<String, dynamic>?)?['message']
              as String? ??
          _httpErrorMessage(e.response?.statusCode);
      state = AuthStateError(message);
    } catch (_) {
      state = const AuthStateError('An unexpected error occurred.');
    }
  }

  Future<void> _saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.authTokenKey, user.token);
    await prefs.setString(AppConstants.userIdKey, user.id);
    await prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  String _httpErrorMessage(int? code) => switch (code) {
    400 => 'Bad Request. Please check your input.',
    401 => 'Incorrect email or password. Please try again.',
    403 => 'Forbidden. You do not have access.',
    404 => 'Not Found. The response does not exists.',
    429 => 'Too Many Requests. Please try again later.',
    500 => 'Internal Server Error. Something went wrong.',
    503 => 'Service Unavailable. Please try again later.',
    null => 'Network Error. Please check your connection.',
    _ => 'Unknown Error. Please try again.',
  };
}
