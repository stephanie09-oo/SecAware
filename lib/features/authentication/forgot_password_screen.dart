
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_dimensions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController();

  // Compact dimensions
  static const double _pagePadding = 16;
  static const double _cardPadding = 18;
  static const double _cardRadius = 18;

  static const double _topSpacing = 10;
  static const double _iconSpacing = 14;
  static const double _descriptionSpacing = 7;
  static const double _formSpacing = 20;
  static const double _labelSpacing = 5;
  static const double _buttonSpacing = 16;
  static const double _bottomSpacing = 8;

  static const double _titleFontSize = 23;
  static const double _bodyFontSize = 11;
  static const double _inputFontSize = 12;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
      child:SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            final isMobile =
                width < AppDimensions.mobileBreakpoint;

            final isCompactHeight = height < 650;

            final horizontalPadding =
            width < 360 ? 10.0 : _pagePadding;

            final cardPadding = isCompactHeight
                ? 14.0
                : isMobile
                ? 16.0
                : _cardPadding;

            final sectionSpacing = isCompactHeight
                ? 12.0
                : _formSpacing;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 8,
                ),
                child: Container(
                  width: AppDimensions.contentWidth(context),
                  padding: EdgeInsets.all(cardPadding),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius:
                    BorderRadius.circular(_cardRadius),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          tooltip: 'Go back',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      ),

                      SizedBox(height: _topSpacing),

                      // Lock icon
                      Icon(
                        Icons.lock_reset,
                        color: AppColors.cyan,
                        size: isCompactHeight ? 38 : 44,
                      ),

                      SizedBox(height: _iconSpacing),

                      // Title
                      const Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: _titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: _descriptionSpacing),

                      // Description
                      const Text(
                        'Enter your email address and we will send '
                            'you instructions to reset your password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: _bodyFontSize,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: sectionSpacing),

                      // Email label
                      const Text(
                        'EMAIL',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: _labelSpacing),

                      // Email input
                      TextField(
                        controller: emailController,
                        keyboardType:
                        TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [
                          AutofillHints.email,
                        ],
                        onSubmitted: (_) => resetPassword(),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: _inputFontSize,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(
                            color: Color(0xFF526078),
                            fontSize: _bodyFontSize,
                          ),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: AppColors.grey,
                            size: 17,
                          ),
                          prefixIconConstraints:
                          const BoxConstraints(
                            minWidth: 38,
                            minHeight: 38,
                          ),
                          filled: true,
                          fillColor:
                          AppColors.inputBackground,
                          isDense: true,
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 11,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              AppDimensions.inputRadius,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                              AppDimensions.inputRadius,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.cyan,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: _buttonSpacing),

                      // Reset password button
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: resetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor:
                            AppColors.background,
                            elevation: 0,
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                AppDimensions.inputRadius,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                'Reset Password',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 7),
                              Icon(
                                Icons.arrow_forward,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: _bottomSpacing),

                      // Back to login
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                          },
                          style: TextButton.styleFrom(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize:
                            MaterialTapTargetSize
                                .shrinkWrap,
                          ),
                          child: const Text(
                            'Back to Login',
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  void resetPassword() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showMessage('Please enter your email');
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(email)) {
      showMessage('Please enter a valid email address');
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Reset Password',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'The password reset feature will be connected '
                'to the authentication system later.',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
