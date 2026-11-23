
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';



import 'core/ databases/api/Auth_Interceptor.dart';
import 'core/ databases/api/api_consumer.dart';
import 'core/ databases/api/dio_consumer.dart';
import 'core/ databases/api/end_points.dart';
import 'core/ databases/cache/token_storage.dart';
import 'core/theme/app_theme.dart';

import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';

import 'features/authentication/presentation/screens/login_screen.dart';
import 'features/authentication/presentation/screens/signup_screen.dart';
import 'features/authentication/presentation/screens/forgot_password_screen.dart';
import 'features/authentication/presentation/screens/reset_password_screen.dart';

import 'features/home/home_screen.dart';
import 'features/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final TokenStorage tokenStorage = TokenStorage();

  final Dio dio = Dio();

  dio.interceptors.add(
    AuthInterceptor(tokenStorage: tokenStorage),
  );

  final ApiConsumer api = DioConsumer(
    dio: dio,
    baseUrl: getBaseUrl(),
  );

  final AuthRepository authRepository =
  AuthRepositoryImpl(api: api);

  runApp(
    SecAwareApp(
      authRepository: authRepository,
      tokenStorage: tokenStorage,
    ),
  );
}

String getBaseUrl() {
  if (EndPoints.customBaseUrl.isNotEmpty) {
    return EndPoints.customBaseUrl;
  }

  if (kIsWeb) {
    return EndPoints.localhost;
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return EndPoints.androidEmulator;

    default:
      return EndPoints.localhost;
  }
}

class SecAwareApp extends StatelessWidget {
  final AuthRepository authRepository;
  final TokenStorage tokenStorage;

  const SecAwareApp({
    super.key,
    required this.authRepository,
    required this.tokenStorage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authRepository: authRepository,
        tokenStorage: tokenStorage,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SecAware',
        theme: AppTheme.theme,

        routes: {
          '/': (context) => SplashScreen(),

          '/login': (context) => LoginScreen(),

          '/signup': (context) => SignupScreen(),

          '/forgot-password': (context) =>
              ForgotPasswordScreen(),

          '/home': (context) => HomeScreen(),
        },

        onGenerateRoute: (settings) {
          final uri = Uri.tryParse(
            settings.name ?? '',
          );

          if (uri?.path == '/reset-password') {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ResetPasswordScreen(
                token:
                uri?.queryParameters['token'] ?? '',
              ),
            );
          }

          return null;
        },
      ),
    );
  }
}

