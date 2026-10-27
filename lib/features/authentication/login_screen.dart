
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool rememberMe = false;
  bool obscurePassword = true;

  static const double _pagePadding = 16;
  static const double _cardPadding = 20;
  static const double _cardRadius = 18;

  static const double _headerSpacing = 20;
  static const double _sectionSpacing = 18;
  static const double _fieldSpacing = 12;
  static const double _smallSpacing = 6;

  @override
  void dispose() {
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

                  final isCompactHeight = height < 700;
                  final isMobile =
                      width < AppDimensions.mobileBreakpoint;

                  final horizontalPadding =
                  width < 360 ? 12.0 : _pagePadding;

                  final cardPadding = isCompactHeight
                      ? 16.0
                      : isMobile
                      ? 18.0
                      : _cardPadding;

                  final sectionSpacing =
                  isCompactHeight ? 14.0 : _sectionSpacing;

                  final fieldSpacing =
                  isCompactHeight ? 10.0 : _fieldSpacing;

                  return Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 10,
                        ),
                        child: Container(
                          width: AppDimensions.contentWidth(context),
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(
                              _cardRadius,
                            ),
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
                          const SizedBox(width: 6),
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
                              size: 11,
                            ),
                            label: const Text(
                              'Back to Home',
                              maxLines: 1,
                              style: TextStyle(fontSize: 11),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.grey,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          ],
                        ),

                        SizedBox(
                          height: isCompactHeight
                              ? 16
                              : _headerSpacing,
                        ),

                        // Title
                        Text(
                          'Welcome Back',
                          style: Theme.of(context)
                              .textTheme.displayLarge
                              ?.copyWith(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: _smallSpacing),

                        Text(
                          'Sign in to your account to continue.',
                          style: Theme.of(context)
                              .textTheme.bodyMedium
                              ?.copyWith(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),

                        SizedBox(height: sectionSpacing),

                        _buildLabel('WORK EMAIL'),
                        const SizedBox(height: 6),

                        _buildInput(
                          controller: emailController,
                          hint: 'admin@acme.com',
                          icon: Icons.mail_outline,
                          keyboardType:
                          TextInputType.emailAddress,
                        ),

                        SizedBox(height: fieldSpacing),

                        Row(
                          children: [
                            _buildLabel('PASSWORD'),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/forgot-password',
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                foregroundColor: AppColors.cyan,
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

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
                              minWidth: 38,
                              minHeight: 38,
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

                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 34,
                              child: Transform.scale(
                                scale: 0.85,
                                child: Checkbox(
                                  value: rememberMe,
                                  activeColor: AppColors.primary,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                'Remember me for 30 days',
                                style: Theme.of(context)
                                    .textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppColors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: fieldSpacing),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              if (emailController.text
                                  .trim()
                                  .isEmpty ||
                                  passwordController.text.isEmpty) {
                                showMessage(
                                  'Please enter your email and password',
                                );
                                return;
                              }

                              showMessage(
                                'Login UI is ready. Authentication '
                                    'will be connected later.',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: sectionSpacing),
                               Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.border,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 9,
                                    ),
                                    child: Text(
                                      'OR CONTINUE WITH',
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 9,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.border,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: isCompactHeight ? 14 : 18,
                              ),

                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment:
                                  WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: Theme.of(context)
                                          .textTheme.bodyMedium
                                          ?.copyWith(
                                        color: AppColors.grey,
                                        fontSize: 11,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/signup',
                                        );
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: Theme.of(context)
                                            .textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppColors.primary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
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

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme.labelMedium
          ?.copyWith(
        color: AppColors.grey,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
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
      style: Theme.of(context)
          .textTheme.bodyMedium
          ?.copyWith(
        color: AppColors.white,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme.bodyMedium
            ?.copyWith(
          color: const Color(0xFF526078),
          fontSize: 11,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.grey,
          size: 17,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 38,
          minHeight: 40,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.inputBackground,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

