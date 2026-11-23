
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({
    super.key,
    required this.token,
  });

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (isLoading) return;

    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (widget.token.trim().isEmpty) {
      showMessage('Invalid password reset link');
      return;
    }

    if (password.length < 8) {
      showMessage('Password must be at least 8 characters');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Passwords do not match');
      return;
    }

    final cubit = context.read<AuthCubit>();

    if (cubit.state is AuthLoading) return;

    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    try {
      await cubit.resetPassword(
        token: widget.token,
        newPassword: password,
      );

      if (!mounted) return;
      if (ModalRoute.of(context)?.isCurrent != true) return;

      final state = cubit.state;

      if (state is AuthSuccess) {
        showMessage('Password updated successfully');

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
              (route) => false,
        );
      } else if (state is AuthError) {
        showMessage(state.message);
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompactHeight =
                  constraints.maxHeight < 650;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: AppDimensions.contentWidth(context),
                    padding: EdgeInsets.all(
                      isCompactHeight ? 14 : 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.lock_reset,
                          color: AppColors.cyan,
                          size: isCompactHeight ? 38 : 44,
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Create a new password for your account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 11,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),

                        if (widget.token.trim().isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Invalid password reset link. '
                                  'Please request a new link.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                              ),
                            ),
                          ),

                        buildLabel('NEW PASSWORD'),
                        const SizedBox(height: 5),

                        buildPasswordField(
                          controller: passwordController,
                          hint: 'Enter new password',
                          obscure: obscurePassword,
                          onToggle: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        buildLabel('CONFIRM PASSWORD'),
                        const SizedBox(height: 5),

                        buildPasswordField(
                          controller: confirmPasswordController,
                          hint: 'Confirm new password',
                          obscure: obscureConfirmPassword,
                          onToggle: () {
                            setState(() {
                              obscureConfirmPassword =
                              !obscureConfirmPassword;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 42,
                          child: ElevatedButton(
                            onPressed: isLoading ||
                                widget.token.trim().isEmpty
                                ? null
                                : resetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.inputRadius,
                                ),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.cyan,
                              ),
                            )
                                : const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update Password',
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

                        const SizedBox(height: 8),

                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                                  (route) => false,
                            );
                          },
                          child: const Text(
                            'Back to Login',
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontSize: 11,
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
      ),
    );
  }

  Widget buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.grey,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      enabled: !isLoading,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF526078),
          fontSize: 11,
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.grey,
          size: 17,
        ),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.grey,
            size: 17,
          ),
        ),
        filled: true,
        fillColor: AppColors.inputBackground,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.cyan,
          ),
        ),
      ),
    );
  }
}
