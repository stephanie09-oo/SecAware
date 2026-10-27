
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

import 'features/home/home_screen.dart';
import 'features/splash/splash_screen.dart';

import 'features/authentication/login_screen.dart';
import 'features/authentication/signup_screen.dart';
import 'features/authentication/forgot_password_screen.dart';

void main() {
  runApp(const SecAwareApp());
}

class SecAwareApp extends StatelessWidget {
  const SecAwareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'SecAware',

      theme: AppTheme.theme,

      initialRoute: '/',

      routes: {
        '/': (context) => SplashScreen(),

        '/login': (context) =>  LoginScreen(),

        '/signup': (context) =>  SignupScreen(),

        '/forgot-password': (context) =>
         ForgotPasswordScreen(),

        '/home': (context) =>  HomeScreen(),
      },
    );
  }
}

