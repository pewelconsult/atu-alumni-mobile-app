// lib/presentation/pages/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mainController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _progressController.forward();

    // Navigate to next screen after animations complete
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // Navigate to onboarding screen
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ATUColors.primaryBlue.withValues(alpha: .95),
              ATUColors.darkBlue,
              ATUColors.primaryBlue.withValues(alpha: .8),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate responsive sizes based on screen height
              final screenHeight = constraints.maxHeight;
              final logoSize = screenHeight * 0.2; // 20% of screen height
              final spacing = screenHeight * 0.05; // 5% of screen height

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Top section - Logo and University Info
                        Column(
                          children: [
                            SizedBox(height: spacing * 0.5),

                            // ATU Logo container with animated background
                            Container(
                              width: logoSize,
                              height: logoSize,
                              decoration: BoxDecoration(
                                color: ATUColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        ATUColors.white.withValues(alpha: .3),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width: logoSize * 0.75,
                                  height: logoSize * 0.75,
                                  decoration: BoxDecoration(
                                    gradient: ATUColors.primaryGradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.school_rounded,
                                    size: logoSize * 0.4,
                                    color: ATUColors.white,
                                  ),
                                ),
                              ),
                            )
                                .animate()
                                .scale(
                                  begin: const Offset(0.5, 0.5),
                                  end: const Offset(1.0, 1.0),
                                  duration: 800.ms,
                                  curve: Curves.elasticOut,
                                )
                                .fadeIn(duration: 600.ms),

                            SizedBox(height: spacing * 0.8),

                            // University name
                            Text(
                              'ACCRA TECHNICAL\nUNIVERSITY',
                              textAlign: TextAlign.center,
                              style: ATUTextStyles.h2.copyWith(
                                color: ATUColors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                height: 1.2,
                                fontSize: screenHeight < 600
                                    ? 20
                                    : 28, // Responsive font size
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  delay: 400.ms,
                                  duration: 600.ms,
                                )
                                .slideY(
                                  begin: 0.3,
                                  end: 0,
                                  duration: 600.ms,
                                  curve: Curves.easeOut,
                                ),

                            SizedBox(height: spacing * 0.4),

                            // Motto with golden accent
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    ATUColors.primaryGold.withValues(alpha: .2),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: ATUColors.primaryGold
                                      .withValues(alpha: .5),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Integrity, Creativity & Excellence',
                                style: ATUTextStyles.bodyMedium.copyWith(
                                  color: ATUColors.primaryGold,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  fontSize: screenHeight < 600
                                      ? 12
                                      : 14, // Responsive font size
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  delay: 800.ms,
                                  duration: 600.ms,
                                )
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.0, 1.0),
                                  delay: 800.ms,
                                  duration: 400.ms,
                                ),
                          ],
                        ),

                        // Middle section - App branding
                        Column(
                          children: [
                            Text(
                              'Alumni Connect',
                              style: ATUTextStyles.h4.copyWith(
                                color: ATUColors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: screenHeight < 600
                                    ? 16
                                    : 20, // Responsive font size
                              ),
                            ).animate().fadeIn(
                                  delay: 1600.ms,
                                  duration: 600.ms,
                                ),

                            SizedBox(height: spacing * 0.2),

                            Text(
                              'Stay Connected • Track Progress • Build Networks',
                              style: ATUTextStyles.bodySmall.copyWith(
                                color: ATUColors.white.withValues(alpha: .8),
                                fontSize: screenHeight < 600
                                    ? 10
                                    : 12, // Responsive font size
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(
                                  delay: 1800.ms,
                                  duration: 600.ms,
                                ),

                            SizedBox(height: spacing * 0.4),

                            // Established year badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: ATUColors.white.withValues(alpha: .1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'ESTABLISHED 1949',
                                style: ATUTextStyles.caption.copyWith(
                                  color: ATUColors.white.withValues(alpha: .8),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: screenHeight < 600
                                      ? 8
                                      : 12, // Responsive font size
                                ),
                              ),
                            ).animate().fadeIn(
                                  delay: 1200.ms,
                                  duration: 600.ms,
                                ),
                          ],
                        ),

                        // Bottom section - Loading
                        Column(
                          children: [
                            // Animated loading indicator
                            Container(
                              width: constraints.maxWidth *
                                  0.6, // 60% of screen width
                              height: 4,
                              decoration: BoxDecoration(
                                color: ATUColors.white.withValues(alpha: .2),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, child) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: (constraints.maxWidth * 0.6) *
                                          _progressController.value,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient: ATUColors.goldGradient,
                                        borderRadius: BorderRadius.circular(2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ATUColors.primaryGold
                                                .withValues(alpha: .5),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ).animate().fadeIn(
                                  delay: 2000.ms,
                                  duration: 400.ms,
                                ),

                            SizedBox(height: spacing * 0.3),

                            Text(
                              'Loading...',
                              style: ATUTextStyles.caption.copyWith(
                                color: ATUColors.white.withValues(alpha: .7),
                                fontSize: screenHeight < 600
                                    ? 10
                                    : 12, // Responsive font size
                              ),
                            ).animate().fadeIn(
                                  delay: 2200.ms,
                                  duration: 400.ms,
                                ),

                            SizedBox(height: spacing * 0.5),
                          ],
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
}
