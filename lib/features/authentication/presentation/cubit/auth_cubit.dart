
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';


import '../../../../core/ databases/cache/token_storage.dart';
import '../../domain/repositories/auth_repository.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final TokenStorage tokenStorage;

  dynamic currentUser;

  bool _isBusy = false;

  AuthCubit({
    required this.authRepository,
    required this.tokenStorage,
  }) : super(AuthInitial());

  // ================= LOGIN =================

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await _runOperation(
      AuthOperation.login,
          () async {
        final loginResponse = await authRepository.login(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        if (loginResponse.token.isEmpty) {
          throw Exception(
            'Login response does not contain a token',
          );
        }

        if (!DateTime.now().toUtc().isBefore(
          loginResponse.expiresAt.toUtc(),
        )) {
          throw Exception(
            'The received token has expired',
          );
        }

        await tokenStorage.saveToken(
          token: loginResponse.token,
          expiresAt: loginResponse.expiresAt,
          rememberMe: rememberMe,
        );

        currentUser = loginResponse;
      },
    );
  }

  // ================= SIGNUP =================

  Future<void> signup({
    required String accountType,
    required String name,
    String? orgName,
    required String email,
    required String password,
    String? orgId,
  }) async {
    await _runOperation(
      AuthOperation.signup,
          () async {
        await authRepository.signup(
          accountType: accountType,
          name: name,
          orgName: orgName,
          email: email,
          password: password,
          orgId: orgId,
        );
      },
    );
  }

  // ================= FORGOT PASSWORD =================

  Future<void> forgotPassword({
    required String email,
  }) async {
    await _runOperation(
      AuthOperation.forgotPassword,
          () async {
        await authRepository.forgotPassword(
          email: email,
        );
      },
    );
  }

  // ================= RESET PASSWORD =================

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await _runOperation(
      AuthOperation.resetPassword,
          () async {
        await authRepository.resetPassword(
          token: token,
          newPassword: newPassword,
        );
      },
    );
  }

  // ================= CHANGE PASSWORD =================

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _runOperation(
      AuthOperation.changePassword,
          () async {
        await authRepository.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );
      },
    );
  }

  // ================= CHECK SESSION =================

  Future<void> checkSession() async {
    if (_isBusy || isClosed) return;

    _isBusy = true;

    emit(AuthSessionChecking());

    try {
      final token = await tokenStorage.getToken();

      if (token == null || token.isEmpty) {
        currentUser = null;
        _safeEmit(AuthUnauthenticated());
        return;
      }

      currentUser =
      await authRepository.getCurrentUser();

      _safeEmit(AuthAuthenticated());
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _clearExpiredSession();
      } else {
        _safeEmit(
          AuthSessionError(_getErrorMessage(error)),
        );
      }
    } catch (error) {
      _safeEmit(
        AuthSessionError(_getErrorMessage(error)),
      );
    } finally {
      _isBusy = false;
    }
  }

  // ================= GET CURRENT USER =================

  Future<void> getCurrentUser() async {
    if (_isBusy || isClosed) return;

    _isBusy = true;

    emit(
      AuthLoading(AuthOperation.getCurrentUser),
    );

    try {
      final token = await tokenStorage.getToken();

      if (token == null || token.isEmpty) {
        await _clearExpiredSession();
        return;
      }

      currentUser =
      await authRepository.getCurrentUser();

      _safeEmit(AuthUserLoaded(currentUser));
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _clearExpiredSession();
      } else {
        _safeEmit(
          AuthError(
            _getErrorMessage(error),
            AuthOperation.getCurrentUser,
          ),
        );
      }
    } catch (error) {
      _safeEmit(
        AuthError(
          _getErrorMessage(error),
          AuthOperation.getCurrentUser,
        ),
      );
    } finally {
      _isBusy = false;
    }
  }

  // ================= LOGOUT =================

  Future<void> logout() async {
    if (_isBusy || isClosed) return;

    _isBusy = true;

    emit(AuthLoading(AuthOperation.logout));

    try {
      await tokenStorage.deleteToken();

      currentUser = null;

      _safeEmit(AuthUnauthenticated());
    } catch (error) {
      _safeEmit(
        AuthError(
          _getErrorMessage(error),
          AuthOperation.logout,
        ),
      );
    } finally {
      _isBusy = false;
    }
  }

  // ================= EXPIRED SESSION =================

  Future<void> _clearExpiredSession() async {
    currentUser = null;

    try {
      await tokenStorage.deleteToken();

      _safeEmit(AuthUnauthenticated());
    } catch (error) {
      _safeEmit(
        AuthSessionError(_getErrorMessage(error)),
      );
    }
  }

  // ================= COMMON OPERATION =================

  Future<void> _runOperation(
      AuthOperation operation,
      Future<void> Function() action,
      ) async {
    if (_isBusy || isClosed) return;

    _isBusy = true;

    emit(AuthLoading(operation));

    try {
      await action();

      _safeEmit(AuthSuccess(operation));
    } catch (error) {
      _safeEmit(
        AuthError(
          _getErrorMessage(error),
          operation,
        ),
      );
    } finally {
      _isBusy = false;
    }
  }

  // ================= SAFE EMIT =================

  void _safeEmit(AuthState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  // ================= ERROR HANDLING =================

  String _getErrorMessage(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timed out. Please try again';

        case DioExceptionType.connectionError:
          return 'Unable to connect to the server';

        case DioExceptionType.cancel:
          return 'Request cancelled';

        default:
          break;
      }

      final response = error.response;

      if (response == null) {
        return 'Unable to complete the request';
      }

      final data = response.data;

      if (data is Map) {
        final errors = data['errors'];

        if (errors is Map) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              return value.first.toString();
            }

            if (value is String && value.isNotEmpty) {
              return value;
            }
          }
        }

        final detail = data['detail'];
        final message = data['message'];
        final title = data['title'];

        if (detail is String && detail.isNotEmpty) {
          return detail;
        }

        if (message is String && message.isNotEmpty) {
          return message;
        }

        if (title is String && title.isNotEmpty) {
          return title;
        }
      }

      switch (response.statusCode) {
        case 400:
          return 'Invalid request. Check your information';

        case 401:
          return 'Authentication failed. Check your credentials';

        case 403:
          return 'You do not have permission';

        case 404:
          return 'Requested resource was not found';

        case 409:
          return 'This information already exists';

        case 429:
          return 'Too many requests. Please try again later';

        case 500:
          return 'Server error. Please try again later';

        default:
          return 'Request failed (${response.statusCode})';
      }
    }

    return 'Unable to complete the operation. Please try again';
  }
}
