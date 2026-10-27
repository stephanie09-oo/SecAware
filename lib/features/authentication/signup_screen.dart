
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_dimensions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController organizationController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isOrganization = true;
  bool obscurePassword = true;

  // Compact screen dimensions
  static const double _pagePadding = 16;
  static const double _cardPadding = 18;
  static const double _cardRadius = 18;

  static const double _topSpacing = 18;
  static const double _sectionSpacing = 16;
  static const double _fieldSpacing = 12;
  static const double _labelSpacing = 5;
  static const double _bottomSpacing = 16;

  static const double _titleFontSize = 23;
  static const double _bodyFontSize = 11;
  static const double _inputFontSize = 12;

  @override
  void dispose() {
    nameController.dispose();
    organizationController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
            final isCompactHeight = height < 700;

            final horizontalPadding =
            width < 360 ? 10.0 : _pagePadding;

            final cardPadding = isCompactHeight
                ? 14.0
                : isMobile
                ? 16.0
                : _cardPadding;

            final sectionSpacing =
            isCompactHeight ? 12.0 : _sectionSpacing;

            final fieldSpacing =
            isCompactHeight ? 10.0 : _fieldSpacing;

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
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Navbar
                      Row(
                        children: [
                          const Icon(
                            Icons.security,
                            color: AppColors.cyan,
                            size: 22,
                          ),
                           SizedBox(width: 6),
                           Text(
                            'SecAware',
                            style: Theme.of(context)
                                .textTheme.headlineSmall
                                ?.copyWith(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                    (route) => false,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 13,
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.grey,
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap,
                            ),

                            label:
                             const Text(
                              'Back to Home',
                              maxLines: 1,
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: _topSpacing),

                      // Title
                       Text(
                        'Create Your Account',
                        style: Theme.of(context)
                            .textTheme.displayLarge
                            ?.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                       SizedBox(height: 5),
                       Text(
                        'Get started with a more secure and aware team.',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: _bodyFontSize,
                        ),
                      ),

                      SizedBox(height: sectionSpacing),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius:
                          BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _accountTypeButton(
                                title: 'Organization',
                                selected: isOrganization,
                                onTap: () {
                                  setState(() {
                                    isOrganization = true;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: _accountTypeButton(
                                title: 'Employee/Student',
                                selected: !isOrganization,
                                onTap: () {
                                  setState(() {
                                    isOrganization = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: sectionSpacing),
                      _buildLabel('FULL NAME'),

                      SizedBox(height: _labelSpacing),

                      _buildInput(
                        controller: nameController,
                        hint: 'John Doe',
                        icon: Icons.person_outline,
                      ),

                      SizedBox(height: fieldSpacing),

                      if (isOrganization) ...[
                        _buildLabel('ORGANIZATION NAME'),

                        SizedBox(height: _labelSpacing),

                        _buildInput(
                          controller: organizationController,
                          hint: 'Acme Corporation',
                          icon: Icons.business_outlined,
                        ),

                        SizedBox(height: fieldSpacing),
                      ],

                      _buildLabel('EMAIL'),

                      SizedBox(height: _labelSpacing),

                      _buildInput(
                        controller: emailController,
                        hint: 'admin@acme.com',
                        icon: Icons.mail_outline,
                        keyboardType:
                        TextInputType.emailAddress,
                      ),

                      SizedBox(height: fieldSpacing),
                      _buildLabel('PASSWORD'),

                      SizedBox(height: _labelSpacing),

                      _buildInput(
                        controller: passwordController,
                        hint: 'Enter your password',
                        icon: Icons.lock_outline,
                        obscure: obscurePassword,
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword =
                              !obscurePassword;
                            });
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.grey,
                            size: 17,
                          ),
                        ),
                      ),

                      SizedBox(height: sectionSpacing),

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: createAccount,
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
                              borderRadius: BorderRadius.circular(
                                AppDimensions.inputRadius,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
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

                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: _bodyFontSize,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/login',
                                );
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: _bodyFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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

  Widget _accountTypeButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 3,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? AppColors.background
                  : AppColors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.grey,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: _inputFontSize,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF526078),
          fontSize: _bodyFontSize,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.grey,
          size: 17,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 38,
          minHeight: 38,
        ),
        suffixIcon: suffix,
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

  void createAccount() {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      showMessage('Please fill in all required fields');
      return;
    }

    if (isOrganization &&
        organizationController.text.trim().isEmpty) {
      showMessage('Please enter your organization name');
      return;
    }

    showMessage(
      'Account UI is ready. Registration will be connected later.',
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
