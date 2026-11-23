import '../../data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<dynamic> signup({
    required String accountType,
    required String name,
    String? orgName,
    required String email,
    required String password,
    String? orgId,
  });

  Future<dynamic> forgotPassword({
    required String email,
  });

  Future<dynamic> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<dynamic> getCurrentUser();
}