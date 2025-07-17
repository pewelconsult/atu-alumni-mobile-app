// lib/presentation/pages/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/common/atu_text_field.dart';
import '../main/main_wrapper.dart';
import '../admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  late AnimationController _animationController;
  late AnimationController _logoAnimationController;

  // Hardcoded test credentials
  static const String testEmail = 'testuser@gmail.com';
  static const String testPassword = 'test123';
  static const String adminPassword = 'test456';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animationController.forward();
    _logoAnimationController.repeat();

    // Pre-fill the form with test credentials for easier testing
    _emailController.text = testEmail;
    _passwordController.text = testPassword;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ATUColors.primaryBlue,
              ATUColors.lightBlue,
              ATUColors.primaryGold,
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight - MediaQuery.of(context).padding.top,
              ),
              child: Column(
                children: [
                  // Enhanced Header section with animated logo
                  Container(
                    padding: const EdgeInsets.fromLTRB(32, 40, 32, 20),
                    child: Column(
                      children: [
                        // Animated ATU Logo with floating effect
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer glow ring
                            Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        ATUColors.white.withValues(alpha: .1),
                                        ATUColors.white.withValues(alpha: .3),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 0.7, 1.0],
                                    ),
                                  ),
                                )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.1, 1.1),
                                  duration: 3000.ms,
                                  curve: Curves.easeInOut,
                                )
                                .fadeIn(duration: 1000.ms),

                            // Main logo container
                            Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        ATUColors.white,
                                        ATUColors.white.withValues(alpha: .95),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: ATUColors.black.withValues(
                                          alpha: .2,
                                        ),
                                        blurRadius: 25,
                                        offset: const Offset(0, 10),
                                        spreadRadius: 2,
                                      ),
                                      BoxShadow(
                                        color: ATUColors.white.withValues(
                                          alpha: .4,
                                        ),
                                        blurRadius: 30,
                                        offset: const Offset(0, -5),
                                        spreadRadius: -5,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          ATUColors.primaryBlue.withValues(
                                            alpha: .1,
                                          ),
                                          ATUColors.primaryGold.withValues(
                                            alpha: .1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.school_rounded,
                                      size: 60,
                                      color: ATUColors.primaryBlue,
                                    ),
                                  ),
                                )
                                .animate()
                                .scale(
                                  begin: const Offset(0.3, 0.3),
                                  duration: 800.ms,
                                  curve: Curves.elasticOut,
                                )
                                .fadeIn(duration: 600.ms),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Enhanced welcome text with gradient
                        ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  ATUColors.white,
                                  ATUColors.white.withValues(alpha: .9),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                'Welcome Back!',
                                style: ATUTextStyles.h1.copyWith(
                                  color: ATUColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 800.ms)
                            .slideY(
                              begin: 0.3,
                              end: 0,
                              delay: 400.ms,
                              duration: 800.ms,
                              curve: Curves.easeOutQuart,
                            ),

                        const SizedBox(height: 12),

                        Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: ATUColors.white.withValues(alpha: .15),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: ATUColors.white.withValues(alpha: .3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Sign in to your ATU Alumni account',
                                style: ATUTextStyles.bodyLarge.copyWith(
                                  color: ATUColors.white.withValues(alpha: .95),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 600.ms, duration: 800.ms)
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              delay: 600.ms,
                              duration: 800.ms,
                            ),
                      ],
                    ),
                  ),

                  // Enhanced Login form with glassmorphism effect
                  Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ATUColors.white.withValues(alpha: .95),
                                ATUColors.white.withValues(alpha: .9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: ATUColors.white.withValues(alpha: .3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ATUColors.black.withValues(alpha: .15),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: ATUColors.white.withValues(alpha: .8),
                                blurRadius: 20,
                                offset: const Offset(0, -5),
                                spreadRadius: -10,
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Enhanced test credentials info
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        ATUColors.info.withValues(alpha: .08),
                                        ATUColors.primaryBlue.withValues(
                                          alpha: .05,
                                        ),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: ATUColors.info.withValues(
                                        alpha: .2,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  ATUColors.info,
                                                  ATUColors.info.withValues(
                                                    alpha: .8,
                                                  ),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons
                                                  .admin_panel_settings_rounded,
                                              color: ATUColors.white,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Demo Credentials',
                                            style: ATUTextStyles.bodyMedium
                                                .copyWith(
                                                  color: ATUColors.info,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      _buildCredentialRow(
                                        'Alumni User',
                                        'testuser@gmail.com',
                                        'test123',
                                        Icons.person_rounded,
                                        ATUColors.success,
                                      ),
                                      const SizedBox(height: 8),
                                      _buildCredentialRow(
                                        'Admin User',
                                        'testuser@gmail.com',
                                        'test456',
                                        Icons.admin_panel_settings_rounded,
                                        ATUColors.primaryGold,
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(
                                  delay: 800.ms,
                                  duration: 600.ms,
                                ),

                                const SizedBox(height: 28),

                                // Form title
                                Text(
                                  'Sign In',
                                  style: ATUTextStyles.h4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ATUColors.grey900,
                                  ),
                                ).animate().fadeIn(
                                  delay: 900.ms,
                                  duration: 400.ms,
                                ),

                                const SizedBox(height: 24),

                                // Enhanced email field
                                ATUTextField(
                                      label: 'Email Address',
                                      hint: 'Enter your email address',
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icons.email_outlined,
                                      validator: _validateEmail,
                                    )
                                    .animate()
                                    .fadeIn(delay: 1000.ms, duration: 400.ms)
                                    .slideX(
                                      begin: -0.1,
                                      end: 0,
                                      delay: 1000.ms,
                                      duration: 600.ms,
                                      curve: Curves.easeOutQuart,
                                    ),

                                const SizedBox(height: 20),

                                // Enhanced password field
                                ATUTextField(
                                      label: 'Password',
                                      hint: 'Enter your password',
                                      controller: _passwordController,
                                      obscureText: !_isPasswordVisible,
                                      prefixIcon: Icons.lock_outlined,
                                      suffixIcon: _isPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      onSuffixTap: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      validator: _validatePassword,
                                    )
                                    .animate()
                                    .fadeIn(delay: 1100.ms, duration: 400.ms)
                                    .slideX(
                                      begin: -0.1,
                                      end: 0,
                                      delay: 1100.ms,
                                      duration: 600.ms,
                                      curve: Curves.easeOutQuart,
                                    ),

                                const SizedBox(height: 20),

                                // Enhanced remember me and forgot password
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: _rememberMe
                                                  ? ATUColors.primaryBlue
                                                  : ATUColors.grey300,
                                              width: 2,
                                            ),
                                          ),
                                          child: Checkbox(
                                            value: _rememberMe,
                                            onChanged: (value) {
                                              setState(() {
                                                _rememberMe = value ?? false;
                                              });
                                            },
                                            activeColor: ATUColors.primaryBlue,
                                            checkColor: ATUColors.white,
                                            side: BorderSide.none,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Remember me',
                                          style: ATUTextStyles.bodyMedium
                                              .copyWith(
                                                color: ATUColors.grey700,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextButton(
                                        onPressed: _forgotPassword,
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: Text(
                                          'Forgot Password?',
                                          style: ATUTextStyles.bodyMedium
                                              .copyWith(
                                                color: ATUColors.primaryGold,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn(
                                  delay: 1200.ms,
                                  duration: 400.ms,
                                ),

                                const SizedBox(height: 32),

                                // Enhanced login button with gradient
                                Container(
                                      width: double.infinity,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        gradient: _isLoading
                                            ? LinearGradient(
                                                colors: [
                                                  ATUColors.grey400,
                                                  ATUColors.grey500,
                                                ],
                                              )
                                            : ATUColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: _isLoading
                                            ? []
                                            : [
                                                BoxShadow(
                                                  color: ATUColors.primaryBlue
                                                      .withValues(alpha: .4),
                                                  blurRadius: 15,
                                                  offset: const Offset(0, 8),
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: _isLoading ? null : _login,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: _isLoading
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(
                                                                ATUColors.white,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Text(
                                                        'Signing In...',
                                                        style: ATUTextStyles
                                                            .buttonText
                                                            .copyWith(
                                                              color: ATUColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.login_rounded,
                                                        color: ATUColors.white,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        'Sign In',
                                                        style: ATUTextStyles
                                                            .buttonText
                                                            .copyWith(
                                                              color: ATUColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 1300.ms, duration: 400.ms)
                                    .slideY(
                                      begin: 0.1,
                                      end: 0,
                                      delay: 1300.ms,
                                      duration: 600.ms,
                                      curve: Curves.easeOutQuart,
                                    ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 800.ms)
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        delay: 700.ms,
                        duration: 800.ms,
                        curve: Curves.easeOutQuart,
                      ),

                  const SizedBox(height: 32),

                  // Enhanced sign up prompt
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: ATUColors.white.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ATUColors.white.withValues(alpha: .3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: ATUTextStyles.bodyMedium.copyWith(
                            color: ATUColors.white.withValues(alpha: .9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToSignUp,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ATUColors.primaryGold,
                                  ATUColors.primaryGold.withValues(alpha: .8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Sign Up',
                              style: ATUTextStyles.bodyMedium.copyWith(
                                color: ATUColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 1400.ms, duration: 600.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialRow(
    String role,
    String email,
    String password,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: .2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$email / $password',
                  style: ATUTextStyles.caption.copyWith(
                    color: ATUColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Check hardcoded credentials
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email == testEmail && password == testPassword) {
        // Regular user login - navigate to main app
        if (mounted) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainWrapper(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
      } else if (email == testEmail && password == adminPassword) {
        // Admin login - navigate to admin dashboard
        if (mounted) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AdminDashboard(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
      } else {
        // Invalid credentials
        if (mounted) {
          _showErrorDialog(
            'Invalid credentials',
            'Please use the demo credentials shown above to test the application.',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(
          'Login failed',
          'An unexpected error occurred. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _forgotPassword() {
    _showInfoDialog(
      'Coming Soon',
      'Password reset functionality will be available in the next update!',
    );
  }

  void _navigateToSignUp() {
    _showInfoDialog(
      'Coming Soon',
      'Registration functionality will be available in the next update!',
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: ATUColors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ATUColors.error,
                    ATUColors.error.withValues(alpha: .8),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: ATUColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: ATUTextStyles.h6.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: ATUTextStyles.bodyMedium.copyWith(
            color: ATUColors.grey700,
            height: 1.5,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ATUButton(
              text: 'Try Again',
              onPressed: () => Navigator.of(context).pop(),
              type: ATUButtonType.primary,
              icon: Icons.refresh_rounded,
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: ATUColors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ATUColors.info,
                    ATUColors.info.withValues(alpha: .8),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: ATUColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: ATUTextStyles.h6.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: ATUTextStyles.bodyMedium.copyWith(
            color: ATUColors.grey700,
            height: 1.5,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ATUButton(
              text: 'Got it!',
              onPressed: () => Navigator.of(context).pop(),
              type: ATUButtonType.primary,
              icon: Icons.check_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
