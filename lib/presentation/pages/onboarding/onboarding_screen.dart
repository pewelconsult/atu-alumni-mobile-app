// lib/presentation/pages/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../auth/login_screen.dart';
import 'dart:math' as math;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _backgroundAnimationController;
  late AnimationController _floatingElementsController;
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Welcome to ATU Alumni Connect',
      subtitle: 'Your Gateway to Alumni Excellence',
      description:
          'Join thousands of ATU graduates in a thriving professional community.',
      icon: Icons.people_alt_rounded,
      primaryColor: ATUColors.primaryBlue,
      secondaryColor: ATUColors.lightBlue,
      features: [
        'Network with Alumni',
        'Share Experiences',
        'Build Connections',
      ],
    ),
    OnboardingData(
      title: 'Track Your Career Journey',
      subtitle: 'Shape the Future of ATU',
      description:
          'Participate in meaningful surveys that help ATU understand graduate success.',
      icon: Icons.trending_up_rounded,
      primaryColor: ATUColors.primaryGold,
      secondaryColor: ATUColors.darkGold,
      features: ['Career Tracking', 'Impact Studies', 'Program Feedback'],
    ),
    OnboardingData(
      title: 'Unlock New Opportunities',
      subtitle: 'Accelerate Your Career Growth',
      description:
          'Discover exclusive job openings and attend premium networking events.',
      icon: Icons.rocket_launch_rounded,
      primaryColor: ATUColors.success,
      secondaryColor: ATUColors.info,
      features: ['Exclusive Jobs', 'Premium Events', 'Career Resources'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _floatingElementsController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundAnimationController.dispose();
    _floatingElementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      body: Stack(
        children: [
          // Enhanced Animated Background
          _buildAnimatedBackground(),

          // Floating Elements
          _buildFloatingElements(),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Enhanced Header
                _buildEnhancedHeader(isSmallScreen),

                // Page View Content - Flexible to take available space
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return EnhancedOnboardingPage(
                        data: _pages[index],
                        isActive: index == _currentPage,
                        pageIndex: index,
                        screenSize: screenSize,
                        isSmallScreen: isSmallScreen,
                      );
                    },
                  ),
                ),

                // Enhanced Bottom Navigation - Fixed height
                _buildEnhancedBottomNavigation(isSmallScreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _pages[_currentPage].primaryColor.withValues(alpha: .1),
                _pages[_currentPage].secondaryColor.withValues(alpha: .05),
                ATUColors.white,
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: BackgroundPatternPainter(
              animation: _backgroundAnimationController,
              color: _pages[_currentPage].primaryColor,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }

  Widget _buildFloatingElements() {
    return AnimatedBuilder(
      animation: _floatingElementsController,
      builder: (context, child) {
        return Stack(
          children: [
            ...List.generate(6, (index) {
              final double animationOffset =
                  (_floatingElementsController.value + index * 0.16) % 1.0;
              return _buildFloatingElement(index, animationOffset);
            }),
          ],
        );
      },
    );
  }

  Widget _buildFloatingElement(int index, double animationOffset) {
    final screenSize = MediaQuery.of(context).size;
    final isEven = index % 2 == 0;

    return Positioned(
      left:
          (screenSize.width * 0.1) +
          (screenSize.width * 0.8 * (index % 3) / 3) +
          (math.sin(animationOffset * 2 * math.pi) * 20),
      top:
          (screenSize.height * 0.2) +
          (screenSize.height * 0.6 * animationOffset) +
          (math.cos(animationOffset * 2 * math.pi) * 15),
      child: Container(
        width: isEven ? 6 : 4,
        height: isEven ? 6 : 4,
        decoration: BoxDecoration(
          color: _pages[_currentPage].primaryColor.withValues(
            alpha: 0.3 - (animationOffset * 0.2),
          ),
          shape: BoxShape.circle,
        ),
      ).animate().fadeIn(duration: 2000.ms),
    );
  }

  Widget _buildEnhancedHeader(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, isSmallScreen ? 8 : 16, 24, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Enhanced ATU Logo
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ATUColors.white,
                  ATUColors.white.withValues(alpha: .9),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _pages[_currentPage].primaryColor.withValues(
                    alpha: .2,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.school_rounded,
              color: _pages[_currentPage].primaryColor,
              size: isSmallScreen ? 20 : 24,
            ),
          ).animate().scale(delay: 200.ms, duration: 600.ms),

          // Enhanced Skip Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ATUColors.white.withValues(alpha: .9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ATUColors.grey300.withValues(alpha: .5),
                width: 1,
              ),
            ),
            child: TextButton(
              onPressed: _skipOnboarding,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Skip',
                style: ATUTextStyles.bodySmall.copyWith(
                  color: ATUColors.grey700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ).animate().slideX(begin: 0.3, delay: 300.ms, duration: 500.ms),
        ],
      ),
    );
  }

  Widget _buildEnhancedBottomNavigation(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            ATUColors.white.withValues(alpha: .8),
            ATUColors.white,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Enhanced Page Indicators
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: isSmallScreen ? 8 : 10,
            ),
            decoration: BoxDecoration(
              color: ATUColors.white.withValues(alpha: .9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: ATUColors.grey400.withValues(alpha: .2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(_pages.length, (index) {
                  return Row(
                    children: [
                      _buildEnhancedIndicator(index, isSmallScreen),
                      if (index < _pages.length - 1)
                        Container(
                          width: 16,
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: index < _currentPage
                                ? _pages[_currentPage].primaryColor
                                : ATUColors.grey300,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: isSmallScreen ? 16 : 20),

          // Enhanced Navigation Buttons
          Row(
            children: [
              // Enhanced Back Button
              if (_currentPage > 0) ...[
                Expanded(
                  child: Container(
                    height: isSmallScreen ? 48 : 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _pages[_currentPage].primaryColor.withValues(
                          alpha: .3,
                        ),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _previousPage,
                        borderRadius: BorderRadius.circular(14),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_rounded,
                                color: _pages[_currentPage].primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Back',
                                style: ATUTextStyles.bodyMedium.copyWith(
                                  color: _pages[_currentPage].primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Enhanced Next/Get Started Button
              Expanded(
                flex: _currentPage == 0 ? 1 : 1,
                child: Container(
                  height: isSmallScreen ? 48 : 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _pages[_currentPage].primaryColor,
                        _pages[_currentPage].secondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: _pages[_currentPage].primaryColor.withValues(
                          alpha: .3,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _currentPage == _pages.length - 1
                          ? _getStarted
                          : _nextPage,
                      borderRadius: BorderRadius.circular(14),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Continue',
                              style: ATUTextStyles.bodyMedium.copyWith(
                                color: ATUColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              _currentPage == _pages.length - 1
                                  ? Icons.rocket_launch_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: ATUColors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (!isSmallScreen) ...[
            const SizedBox(height: 8),
            // Progress Text
            Text(
              '${_currentPage + 1} of ${_pages.length}',
              style: ATUTextStyles.caption.copyWith(
                color: ATUColors.grey500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEnhancedIndicator(int index, bool isSmallScreen) {
    final isActive = index == _currentPage;
    final isPassed = index < _currentPage;
    final size = isSmallScreen ? 20.0 : 24.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? size + 4 : size,
      height: isActive ? size + 4 : size,
      decoration: BoxDecoration(
        gradient: isActive || isPassed
            ? LinearGradient(
                colors: [
                  _pages[_currentPage].primaryColor,
                  _pages[_currentPage].secondaryColor,
                ],
              )
            : null,
        color: isActive || isPassed ? null : ATUColors.grey300,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: _pages[_currentPage].primaryColor.withValues(
                    alpha: .4,
                  ),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Center(
        child: isPassed
            ? Icon(
                Icons.check_rounded,
                color: ATUColors.white,
                size: isSmallScreen ? 12 : 14,
              )
            : Container(
                width: isActive ? 6 : 5,
                height: isActive ? 6 : 5,
                decoration: BoxDecoration(
                  color: isActive ? ATUColors.white : ATUColors.grey500,
                  shape: BoxShape.circle,
                ),
              ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _skipOnboarding() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _getStarted() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  ),
                ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}

class EnhancedOnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final bool isActive;
  final int pageIndex;
  final Size screenSize;
  final bool isSmallScreen;

  const EnhancedOnboardingPage({
    super.key,
    required this.data,
    required this.isActive,
    required this.pageIndex,
    required this.screenSize,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Enhanced Illustration Container
          SizedBox(
                width: isSmallScreen ? 120 : 150,
                height: isSmallScreen ? 120 : 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated background circles
                    ...List.generate(2, (index) {
                      final size = (isSmallScreen ? 120 : 150) - (index * 20.0);
                      return Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  data.primaryColor.withValues(
                                    alpha: 0.1 - index * 0.03,
                                  ),
                                  data.secondaryColor.withValues(
                                    alpha: 0.05 - index * 0.02,
                                  ),
                                  Colors.transparent,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .scale(
                            begin: Offset(
                              0.9 + index * 0.05,
                              0.9 + index * 0.05,
                            ),
                            end: Offset(1.1 - index * 0.05, 1.1 - index * 0.05),
                            duration: Duration(
                              milliseconds: 3000 + index * 500,
                            ),
                            curve: Curves.easeInOut,
                          );
                    }),

                    // Main illustration container
                    Container(
                      width: isSmallScreen ? 100 : 120,
                      height: isSmallScreen ? 100 : 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [data.primaryColor, data.secondaryColor],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: data.primaryColor.withValues(alpha: .3),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        data.icon,
                        size: isSmallScreen ? 50 : 60,
                        color: ATUColors.white,
                      ),
                    ),
                  ],
                ),
              )
              .animate(target: isActive ? 1 : 0)
              .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1.0, 1.0),
                duration: 800.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: 600.ms),

          SizedBox(height: isSmallScreen ? 24 : 32),

          // Enhanced Title
          ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [data.primaryColor, data.secondaryColor],
                ).createShader(bounds),
                child: Text(
                  data.title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 22 : 26,
                    fontWeight: FontWeight.bold,
                    color: ATUColors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              .animate(target: isActive ? 1 : 0)
              .fadeIn(delay: 200.ms, duration: 800.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                delay: 200.ms,
                duration: 800.ms,
                curve: Curves.easeOutQuart,
              ),

          SizedBox(height: isSmallScreen ? 12 : 16),

          // Enhanced Subtitle
          Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16 : 20,
                  vertical: isSmallScreen ? 6 : 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      data.primaryColor.withValues(alpha: .1),
                      data.secondaryColor.withValues(alpha: .05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: data.primaryColor.withValues(alpha: .2),
                    width: 1,
                  ),
                ),
                child: Text(
                  data.subtitle,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: data.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 13 : 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              .animate(target: isActive ? 1 : 0)
              .fadeIn(delay: 400.ms, duration: 800.ms)
              .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 800.ms),

          SizedBox(height: isSmallScreen ? 16 : 20),

          // Enhanced Description
          Text(
                data.description,
                style: ATUTextStyles.bodyMedium.copyWith(
                  color: ATUColors.grey700,
                  height: 1.5,
                  fontSize: isSmallScreen ? 13 : 15,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
              .animate(target: isActive ? 1 : 0)
              .fadeIn(delay: 600.ms, duration: 800.ms)
              .slideY(begin: 0.2, end: 0, delay: 600.ms, duration: 800.ms),

          if (!isSmallScreen) ...[
            const SizedBox(height: 20),

            // Features List (only on larger screens)
            Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ATUColors.white.withValues(alpha: .9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: data.primaryColor.withValues(alpha: .1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ATUColors.grey400.withValues(alpha: .1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: data.features.asMap().entries.map((entry) {
                      final index = entry.key;
                      final feature = entry.value;

                      return Container(
                        margin: EdgeInsets.only(
                          bottom: index < data.features.length - 1 ? 10 : 0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    data.primaryColor,
                                    data.secondaryColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: ATUColors.white,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                feature,
                                style: ATUTextStyles.bodySmall.copyWith(
                                  color: ATUColors.grey800,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
                .animate(target: isActive ? 1 : 0)
                .fadeIn(delay: 800.ms, duration: 800.ms)
                .slideY(begin: 0.2, end: 0, delay: 800.ms, duration: 800.ms),
          ],
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  final List<String> features;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    required this.features,
  });
}

class BackgroundPatternPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  BackgroundPatternPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: .05)
      ..style = PaintingStyle.fill;

    const gridSize = 60.0;
    final offsetX = (animation.value * gridSize) % gridSize;
    final offsetY = (animation.value * gridSize * 0.5) % gridSize;

    for (
      double x = -gridSize + offsetX;
      x < size.width + gridSize;
      x += gridSize
    ) {
      for (
        double y = -gridSize + offsetY;
        y < size.height + gridSize;
        y += gridSize
      ) {
        final rect = Rect.fromCenter(center: Offset(x, y), width: 3, height: 3);
        canvas.drawOval(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BackgroundPatternPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value ||
        oldDelegate.color != color;
  }
}
