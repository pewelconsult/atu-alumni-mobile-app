// lib/presentation/pages/main/main_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import 'alumni_dashboard.dart';
import '../directory/alumni_directory.dart';
import '../events/events_screen.dart';
import '../jobs/jobs_screen.dart';
import '../profile/profile_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AlumniDashboard(),
    const AlumniDirectory(),
    const EventsScreen(),
    const JobsScreen(),
    const ProfileScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_rounded,
      label: 'Home',
      activeColor: ATUColors.primaryBlue,
    ),
    NavigationItem(
      icon: Icons.people_rounded,
      label: 'Directory',
      activeColor: ATUColors.primaryGold,
    ),
    NavigationItem(
      icon: Icons.event_rounded,
      label: 'Events',
      activeColor: ATUColors.info,
    ),
    NavigationItem(
      icon: Icons.work_rounded,
      label: 'Jobs',
      activeColor: ATUColors.success,
    ),
    NavigationItem(
      icon: Icons.person_rounded,
      label: 'Profile',
      activeColor: ATUColors.warning,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ATUColors.white,
          boxShadow: [
            BoxShadow(
              color: ATUColors.grey400.withValues(alpha: .1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navigationItems.length,
                (index) => _buildNavigationItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index) {
    final item = _navigationItems[index];
    final isSelected = index == _currentIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: ATUAnimations.medium,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withValues(alpha: .1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: isSelected ? item.activeColor : ATUColors.grey400,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: ATUTextStyles.caption.copyWith(
                color: isSelected ? item.activeColor : ATUColors.grey400,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1));
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final Color activeColor;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.activeColor,
  });
}
