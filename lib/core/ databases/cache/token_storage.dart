
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage({
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static const String _expiresAtKey = 'auth_expires_at';

  String? _sessionToken;
  DateTime? _sessionExpiresAt;

  Future<void> saveToken({
    required String token,
    required DateTime expiresAt,
    required bool rememberMe,
  }) async {
    // Remove any previously saved session first.
    await deleteToken();

    if (rememberMe) {
      await _storage.write(
        key: _tokenKey,
        value: token,
      );

      await _storage.write(
        key: _expiresAtKey,
        value: expiresAt.toUtc().toIso8601String(),
      );
    } else {
      _sessionToken = token;
      _sessionExpiresAt = expiresAt;
    }
  }

  Future<String?> getToken() async {
    if (_sessionToken != null) {
      if (_sessionExpiresAt != null &&
          DateTime.now().toUtc().isBefore(
            _sessionExpiresAt!.toUtc(),
          )) {
        return _sessionToken;
      }

      await deleteToken();
      return null;
    }

    final token = await _storage.read(
      key: _tokenKey,
    );

    final expiresAtString = await _storage.read(
      key: _expiresAtKey,
    );

    if (token == null || expiresAtString == null) {
      return null;
    }

    final expiresAt = DateTime.tryParse(expiresAtString);

    if (expiresAt == null ||
        !DateTime.now().toUtc().isBefore(
          expiresAt.toUtc(),
        )) {
      await deleteToken();
      return null;
    }

    return token;
  }

  Future<void> deleteToken() async {
    _sessionToken = null;
    _sessionExpiresAt = null;

    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expiresAtKey);
  }
}

