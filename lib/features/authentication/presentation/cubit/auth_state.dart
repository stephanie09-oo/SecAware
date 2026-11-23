
enum AuthOperation {
  login,
  signup,
  forgotPassword,
  resetPassword,
  changePassword,
  logout,
  getCurrentUser,
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final AuthOperation? operation;

  AuthLoading([this.operation]);
}

class AuthSuccess extends AuthState {
  final AuthOperation? operation;

  AuthSuccess([this.operation]);
}

class AuthError extends AuthState {
  final String message;
  final AuthOperation? operation;

  AuthError(this.message, [this.operation]);
}

class AuthSessionChecking extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthSessionError extends AuthState {
  final String message;

  AuthSessionError(this.message);
}

class AuthUserLoaded extends AuthState {
  final dynamic user;

  AuthUserLoaded(this.user);
}
