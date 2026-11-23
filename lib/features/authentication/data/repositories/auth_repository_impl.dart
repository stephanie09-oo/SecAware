import '../../../../core/ databases/api/api_consumer.dart';
import '../../../../core/ databases/api/end_points.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_response_model.dart';


class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer api;

  AuthRepositoryImpl({required this.api});

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await api.post(
      EndPoints.login,
      data: {
        'email': email,
        'password': password,
        'rememberMe': rememberMe,
      },
    );

    return LoginResponseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
    );
  }

  @override
  Future<dynamic> signup({
    required String accountType,
    required String name,
    String? orgName,
    required String email,
    required String password,
    String? orgId,
  }) async {
    return await api.post(
      EndPoints.signup,
      data: {
        'accountType': accountType,
        'name': name,
        'orgName': orgName,
        'email': email,
        'password': password,
        'orgId': orgId,
      },
    );
  }

  @override
  Future<dynamic> forgotPassword({
    required String email,
  }) async {
    return await api.post(
      EndPoints.forgotPassword,
      data: {'email': email},
    );
  }

  @override
  Future<dynamic> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return await api.post(
      EndPoints.resetPassword,
      data: {
        'token': token,
        'newPassword': newPassword,
      },
    );
  }

  @override
  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await api.post(
      EndPoints.changePassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }

  @override
  Future<dynamic> getCurrentUser() async {
    return await api.get(EndPoints.me);
  }
}