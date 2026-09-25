class AppConstants {
  AppConstants._();

  //static const String baseUrl = 'https://api.shopwave.com';
  static const String baseUrl = 'https://localhost:8082';

  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';

  static const String loginRoute = '/login';
  static const String logOutRoute = '/logout';
  static const String productsRoute = '/products';
  static const String productRoute = '/products';
  static const String orderRoute = '/orders';
  static const String profileRoute = '/profile';
}
