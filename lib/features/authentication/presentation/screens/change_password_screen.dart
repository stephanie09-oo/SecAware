
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    if (isLoading) return;

    final currentPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage('Please fill in all fields');
      return;
    }

    if (newPassword.length < 8) {
      showMessage('Password must be at least 8 characters');
      return;
    }

    if (newPassword != confirmPassword) {
      showMessage('Passwords do not match');
      return;
    }

    if (currentPassword == newPassword) {
      showMessage('Please choose a different password');
      return;
    }

    final cubit = context.read<AuthCubit>();

    if (cubit.state is AuthLoading ||
        cubit.state is AuthSessionChecking) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    try {
      await cubit.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (!mounted) return;

      final state = cubit.state;

      if (state is AuthSuccess &&
          state.operation == AuthOperation.changePassword) {
        showMessage('Password changed successfully');
        Navigator.pop(context);
      } else if (state is AuthError &&
          state.operation == AuthOperation.changePassword) {
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: AppDimensions.contentWidth(context),
                padding: const EdgeInsets.all(18),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: isLoading
                            ? null
                            : () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.lock_reset,
                      color: AppColors.cyan,
                      size: 44,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Change Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Update your password to keep '
                          'your account secure.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 20),

                    buildPasswordField(
                      'CURRENT PASSWORD',
                      'Enter current password',
                      currentPasswordController,
                    ),

                    const SizedBox(height: 12),

                    buildPasswordField(
                      'NEW PASSWORD',
                      'Enter new password',
                      newPasswordController,
                    ),

                    const SizedBox(height: 12),

                    buildPasswordField(
                      'CONFIRM PASSWORD',
                      'Confirm new password',
                      confirmPasswordController,
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed:
                        isLoading ? null : changePassword,
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
                            : const Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(
      String label,
      String hint,
      TextEditingController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        _PasswordInput(
          controller: controller,
          hint: hint,
          enabled: !isLoading,
        ),
      ],
    );
  }
}

class _PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool enabled;

  const _PasswordInput({
    required this.controller,
    required this.hint,
    required this.enabled,
  });

  @override
  State<_PasswordInput> createState() =>
      _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: obscure,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: 11,
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.grey,
          size: 17,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() => obscure = !obscure);
          },
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
