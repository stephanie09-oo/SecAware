
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_dimensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const double _topPadding = 30;
  static const double _navbarSpacing = 40;
  static const double _labelSpacing = 30;
  static const double _descriptionSpacing = 20;
  static const double _featuresSpacing = 70;
  static const double _buttonsSpacing = 60;

  static const double _headingSize = 30;
  static const double _largeHeadingSize = 34;
  static const double _bodyFontSize = 13;

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
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              final heightScale =
              (height / 780).clamp(0.72, 1.0).toDouble();

              final widthScale =
              (width / 390).clamp(0.80, 1.0).toDouble();

              final scale = math.min(heightScale, widthScale);

              final textScale =
              (scale * 1.0).clamp(0.78, 1.0).toDouble();

              final horizontalPadding = width < 360
                  ? AppDimensions.sm + 6
                  : width >= AppDimensions.tabletBreakpoint
                  ? AppDimensions.xxl
                  : 22.0;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  _topPadding * scale,
                  horizontalPadding,
                  AppDimensions.sm * scale,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: math.max(
                      0,
                      height - (_topPadding + AppDimensions.sm) * scale,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNavbar(context,scale, textScale),

                      SizedBox(height: _navbarSpacing * scale),

                      _buildPlatformLabel(scale, textScale),

                      SizedBox(height: _labelSpacing * scale),

                      Text(
                        'Turn Security Awareness ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.white,
                          fontSize: _headingSize * textScale,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),

                      Text(
                        'into Real Skills',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.cyan,
                          fontSize: _largeHeadingSize * textScale,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),

                      SizedBox(
                        height: _descriptionSpacing * scale,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.xs * scale,
                        ),
                        child: Text(
                         "Run realistic social engineering simulations,"
                         'generate AI-powered CTF challenges, and measure '
                             'progress — all in one platform',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.grey,
                            fontSize: _bodyFontSize * textScale,
                            height: 1.55,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      SizedBox(height: _featuresSpacing * scale),

                      Text(
                        'FEATURES ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.cyan,
                          fontSize: 11 * textScale,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),

                      SizedBox(height: AppDimensions.md * scale),

                      _featureItem(
                        icon: Icons.security,
                        title: 'Phishing Detection & Reporting',
                        scale: scale,
                        textScale: textScale,
                      ),

                      _featureItem(
                        icon: Icons.notifications_active_outlined,
                        title: 'Learning Notifications',
                        scale: scale,
                        textScale: textScale,
                      ),

                      _featureItem(
                        icon: Icons.document_scanner_outlined,
                        title: 'Capture and detect social engineering attacks',
                        iconColor: AppColors.purple,
                        scale: scale,
                        textScale: textScale,
                      ),

                      SizedBox(height: _buttonsSpacing * scale),

                      _buildActionButtons(
                        context,
                        scale,
                        textScale,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavbar( BuildContext context,double scale, double textScale) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scale,
        vertical: 9 * scale,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius + 2),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security_rounded,
            color: AppColors.cyan,
            size: 23 * scale,
          ),
          SizedBox(width: AppDimensions.sm * scale),
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
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 10 * scale,
                vertical: 6 * scale,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              'Login',
              style: Theme.of(context)
                  .textTheme.headlineSmall
                  ?.copyWith(
                color: AppColors.cyan,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformLabel(double scale, double textScale) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12 * scale,
          vertical: 7 * scale,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF08252C),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF12434D),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'NEXT-GEN CYBERSECURITY PLATFORM',
            maxLines: 1,
            style: GoogleFonts.inter(
              color: AppColors.cyan,
              fontSize: 9 * textScale,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureItem({
    required IconData icon,
    required String title,
    required double scale,
    required double textScale,
    Color iconColor = AppColors.cyan,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.sm * scale),
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scale,
        vertical: 11 * scale,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: AppDimensions.iconSize * scale,
          ),
          SizedBox(width: AppDimensions.sm * 1.5 * scale),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: AppColors.white,
                fontSize: _bodyFontSize * textScale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context,
      double scale,
      double textScale,
      ) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppDimensions.buttonHeight * scale,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              icon: Icon(
                Icons.arrow_forward,
                size: 20 * scale,
              ),
              label: Text(
                'Get Started',
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.inter(
                  fontSize: 16 * textScale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 6 * scale,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppDimensions.sm * 1.25 * scale),
        Expanded(
          child: SizedBox(
            height: AppDimensions.buttonHeight * scale,
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    backgroundColor: AppColors.card,
                    title: Text(
                      'SecAware Demo',
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      'Explore cybersecurity training, '
                          'social engineering simulations, '
                          'and security challenges.',
                      style: GoogleFonts.inter(
                        color: AppColors.grey,
                        height: 1.7,
                        fontSize: 13,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Text(
                          'Close',
                          style: GoogleFonts.inter(
                            color: AppColors.cyan,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 23 * scale,
              ),
              label: Text(
                'Watch Demo',
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.inter(
                  fontSize: 16 * textScale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.white,
                side:  BorderSide(color: AppColors.border),
                padding: EdgeInsets.symmetric(
                  horizontal: 5 * scale,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
