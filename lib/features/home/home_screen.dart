
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.card,

        title:  Text(
          'SecAware',

          style: TextStyle(
            color: AppColors.white,
          ),
        ),

        iconTheme:  IconThemeData(
          color: AppColors.white,
        ),
      ),

      body:  Center(
        child: Text(
          'Welcome to SecAware',

          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
