// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/splash/splash_screen.dart';

void main() {
  runApp(const ATUAlumniApp());
}

class ATUAlumniApp extends StatelessWidget {
  const ATUAlumniApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ATUColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'ATU Alumni Connect',
      debugShowCheckedModeBanner: false,
      theme: ATUTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
