class EndPoints {
  EndPoints._();

  static const String customBaseUrl =
  String.fromEnvironment('API_BASE_URL');

  static const String localhost =
      'http://localhost:5080';

  static const String androidEmulator =
      'http://10.0.2.2:5080';

  static const String login = '/api/auth/login';
  static const String signup = '/api/auth/signup';

  static const String forgotPassword =
      '/api/auth/forgot-password';

  static const String resetPassword =
      '/api/auth/reset-password';

  static const String changePassword =
      '/api/auth/change-password';

  static const String me = '/api/auth/me';
}

