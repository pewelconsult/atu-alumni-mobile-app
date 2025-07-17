// lib/presentation/pages/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/common/atu_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _mockUser = UserProfile(
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+233 24 123 4567',
    graduationYear: '2022',
    program: 'Computer Science',
    currentPosition: 'Senior Software Engineer',
    currentCompany: 'Google Ghana',
    location: 'Accra, Ghana',
    bio:
        'Passionate software engineer with 4+ years of experience in mobile and web development. Alumni of ATU with a focus on creating innovative solutions that impact millions of users.',
    skills: [
      'Flutter',
      'Python',
      'JavaScript',
      'Node.js',
      'React',
      'AWS',
      'Docker',
    ],
    linkedIn: 'linkedin.com/in/johndoe',
    github: 'github.com/johndoe',
    website: 'johndoe.dev',
    profileCompletion: 92,
    connectionsCount: 142,
    eventsAttended: 8,
    surveysCompleted: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(),
                _buildProfileCard(),
                _buildStatsCards(),
                _buildQuickActions(),
                _buildMenuSection(),
                const SizedBox(height: 100), // Space for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildEditProfileFAB(),
    );
  }

  Widget _buildHeader() {
    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ATUColors.primaryBlue.withValues(alpha: .05),
                ATUColors.primaryGold.withValues(alpha: .05),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Profile',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your account and preferences',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.grey600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ATUColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: ATUShadows.soft,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getProfileStatusColor(),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_mockUser.profileCompletion}% complete',
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.grey700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildHeaderActions(),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0, duration: 600.ms);
  }

  Widget _buildHeaderActions() {
    return Row(
      children: [
        // QR Code
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: const Icon(
            Icons.qr_code_rounded,
            color: ATUColors.primaryGold,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        // Settings
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: GestureDetector(
            onTap: () => _showSettingsMenu(),
            child: const Icon(
              Icons.settings_rounded,
              color: ATUColors.primaryBlue,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Color _getProfileStatusColor() {
    if (_mockUser.profileCompletion >= 90) return ATUColors.success;
    if (_mockUser.profileCompletion >= 70) return ATUColors.primaryGold;
    return ATUColors.warning;
  }

  Widget _buildProfileCard() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: ATUColors.cardGradient,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: ATUColors.primaryBlue.withValues(alpha: .1),
              width: 1,
            ),
            boxShadow: ATUShadows.medium,
          ),
          child: Column(
            children: [
              // Enhanced Profile Picture Section
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: ATUColors.brandGradient,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: ATUColors.white,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: ATUColors.primaryBlue,
                        child: Text(
                          _mockUser.name.substring(0, 2).toUpperCase(),
                          style: ATUTextStyles.h2.copyWith(
                            color: ATUColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ATUColors.primaryGold,
                        shape: BoxShape.circle,
                        border: Border.all(color: ATUColors.white, width: 3),
                        boxShadow: ATUShadows.soft,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: ATUColors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // User Info
              Text(
                _mockUser.name,
                style: ATUTextStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: ATUColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _mockUser.currentPosition,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _mockUser.currentCompany,
                style: ATUTextStyles.bodyLarge.copyWith(
                  color: ATUColors.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              // Academic Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ATUColors.grey50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ATUColors.grey200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ATUColors.primaryBlue.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: ATUColors.primaryBlue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _mockUser.program,
                            style: ATUTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ATUColors.grey900,
                            ),
                          ),
                          Text(
                            'Class of ${_mockUser.graduationYear} • ATU',
                            style: ATUTextStyles.bodySmall.copyWith(
                              color: ATUColors.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Enhanced Profile Completion
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getProfileStatusColor().withValues(alpha: .1),
                      _getProfileStatusColor().withValues(alpha: .05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _getProfileStatusColor().withValues(alpha: .3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile Completion',
                          style: ATUTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ATUColors.grey900,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getProfileStatusColor().withValues(
                              alpha: .2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_mockUser.profileCompletion}%',
                            style: ATUTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _getProfileStatusColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: ATUColors.grey200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _mockUser.profileCompletion / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getProfileStatusColor(),
                                _getProfileStatusColor().withValues(alpha: .7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    if (_mockUser.profileCompletion < 100) ...[
                      const SizedBox(height: 12),
                      Text(
                        _getCompletionMessage(),
                        style: ATUTextStyles.bodySmall.copyWith(
                          color: ATUColors.grey600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bio Section
              if (_mockUser.bio.isNotEmpty) ...[
                _buildProfileSection(
                  'About Me',
                  Icons.person_rounded,
                  ATUColors.info,
                  [
                    Text(
                      _mockUser.bio,
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.grey600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],

              // Skills Section
              if (_mockUser.skills.isNotEmpty) ...[
                _buildProfileSection(
                  'Skills & Expertise',
                  Icons.code_rounded,
                  ATUColors.success,
                  [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: _mockUser.skills
                          .map(
                            (skill) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ATUColors.primaryBlue.withValues(alpha: .1),
                                    ATUColors.primaryGold.withValues(alpha: .1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: ATUColors.primaryBlue.withValues(
                                    alpha: .3,
                                  ),
                                ),
                              ),
                              child: Text(
                                skill,
                                style: ATUTextStyles.bodySmall.copyWith(
                                  color: ATUColors.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildProfileSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  String _getCompletionMessage() {
    if (_mockUser.profileCompletion >= 90) return 'Your profile looks great!';
    if (_mockUser.profileCompletion >= 70) {
      return 'Almost there! Add a few more details.';
    }
    return 'Complete your profile to connect better with alumni.';
  }

  Widget _buildStatsCards() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _buildEnhancedStatCard(
                  'Network',
                  _mockUser.connectionsCount.toString(),
                  Icons.people_rounded,
                  ATUColors.primaryBlue,
                  'Connections',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEnhancedStatCard(
                  'Events',
                  _mockUser.eventsAttended.toString(),
                  Icons.event_rounded,
                  ATUColors.success,
                  'Attended',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEnhancedStatCard(
                  'Surveys',
                  _mockUser.surveysCompleted.toString(),
                  Icons.assignment_rounded,
                  ATUColors.primaryGold,
                  'Completed',
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildEnhancedStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: .2), width: 1),
        boxShadow: ATUShadows.soft,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: .7)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: ATUColors.white, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: ATUTextStyles.caption.copyWith(
              color: ATUColors.grey700,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: ATUTextStyles.caption.copyWith(color: ATUColors.grey500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: ATUTextStyles.h5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      'Share Profile',
                      Icons.share_rounded,
                      ATUColors.info,
                      () => _shareProfile(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      'QR Code',
                      Icons.qr_code_rounded,
                      ATUColors.primaryGold,
                      () => _showQRCode(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      'Download CV',
                      Icons.download_rounded,
                      ATUColors.success,
                      () => _downloadCV(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 500.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 500.ms, duration: 600.ms);
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: .3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: ATUTextStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account & Settings',
                style: ATUTextStyles.h5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 16),

              // Personal Information
              _buildEnhancedMenuGroup('Personal Information', [
                _buildEnhancedMenuItem(
                  Icons.person_rounded,
                  'Edit Profile',
                  'Update your personal information',
                  ATUColors.primaryBlue,
                  () => _editProfile(),
                ),
                _buildEnhancedMenuItem(
                  Icons.security_rounded,
                  'Privacy & Security',
                  'Manage your privacy settings',
                  ATUColors.success,
                  () => _showPrivacySettings(),
                ),
                _buildEnhancedMenuItem(
                  Icons.link_rounded,
                  'Social Links',
                  'Add your social media profiles',
                  ATUColors.info,
                  () => _manageSocialLinks(),
                ),
              ]),

              const SizedBox(height: 20),

              // App Settings
              _buildEnhancedMenuGroup('App Settings', [
                _buildEnhancedMenuItem(
                  Icons.notifications_rounded,
                  'Notifications',
                  'Configure notification preferences',
                  ATUColors.primaryGold,
                  () => _showNotificationSettings(),
                ),
                _buildEnhancedMenuItem(
                  Icons.language_rounded,
                  'Language',
                  'Change app language',
                  ATUColors.info,
                  () => _showLanguageSettings(),
                ),
                _buildEnhancedMenuItem(
                  Icons.dark_mode_rounded,
                  'Theme',
                  'Switch between light and dark mode',
                  ATUColors.primaryBlue,
                  () => _showThemeSettings(),
                ),
              ]),

              const SizedBox(height: 20),

              // Support & Legal
              _buildEnhancedMenuGroup('Support & Legal', [
                _buildEnhancedMenuItem(
                  Icons.help_rounded,
                  'Help & Support',
                  'Get help and contact support',
                  ATUColors.success,
                  () => _showHelpSupport(),
                ),
                _buildEnhancedMenuItem(
                  Icons.feedback_rounded,
                  'Send Feedback',
                  'Help us improve the app',
                  ATUColors.primaryGold,
                  () => _sendFeedback(),
                ),
                _buildEnhancedMenuItem(
                  Icons.description_rounded,
                  'Terms & Privacy',
                  'Read our terms and privacy policy',
                  ATUColors.info,
                  () => _showTermsPrivacy(),
                ),
              ]),

              const SizedBox(height: 20),

              // Logout Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ATUColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ATUColors.error.withValues(alpha: .3),
                    width: 1,
                  ),
                  boxShadow: ATUShadows.soft,
                ),
                child: GestureDetector(
                  onTap: _signOut,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ATUColors.error.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: ATUColors.error,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Out',
                              style: ATUTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ATUColors.error,
                              ),
                            ),
                            Text(
                              'Sign out of your account',
                              style: ATUTextStyles.bodySmall.copyWith(
                                color: ATUColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ATUColors.error,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 600.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 600.ms, duration: 600.ms);
  }

  Widget _buildEnhancedMenuGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: ATUTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: ATUShadows.soft,
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: ATUColors.grey200,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedMenuItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: ATUTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ATUColors.grey900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: ATUTextStyles.bodySmall.copyWith(
                      color: ATUColors.grey600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: ATUColors.grey400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditProfileFAB() {
    return FloatingActionButton.extended(
      onPressed: _editProfile,
      backgroundColor: ATUColors.primaryGold,
      foregroundColor: ATUColors.white,
      elevation: 6,
      icon: const Icon(Icons.edit_rounded),
      label: Text(
        'Edit Profile',
        style: ATUTextStyles.buttonTextSmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    ).animate().scale(delay: 800.ms);
  }

  // Enhanced Profile Actions
  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.share, color: ATUColors.white),
            SizedBox(width: 12),
            Text('Profile shared successfully'),
          ],
        ),
        backgroundColor: ATUColors.info,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showQRCode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Your QR Code'),
        content: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: ATUColors.grey100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.qr_code_rounded,
              size: 100,
              color: ATUColors.primaryBlue,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ATUButton(
            text: 'Share',
            onPressed: () {
              Navigator.pop(context);
              _shareProfile();
            },
            type: ATUButtonType.primary,
            size: ATUButtonSize.small,
          ),
        ],
      ),
    );
  }

  void _downloadCV() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.download, color: ATUColors.white),
            SizedBox(width: 12),
            Text('CV download started'),
          ],
        ),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: ATUColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ATUColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Quick Settings',
              style: ATUTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildQuickSettingsItem(
              Icons.notifications_rounded,
              'Notifications',
              'Manage your alerts',
              ATUColors.primaryGold,
              () => Navigator.pop(context),
            ),
            _buildQuickSettingsItem(
              Icons.security_rounded,
              'Privacy',
              'Control your privacy',
              ATUColors.success,
              () => Navigator.pop(context),
            ),
            _buildQuickSettingsItem(
              Icons.help_rounded,
              'Help',
              'Get support',
              ATUColors.info,
              () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSettingsItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: ATUTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: ATUTextStyles.bodySmall.copyWith(color: ATUColors.grey600),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: ATUColors.grey400,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: ATUColors.grey50,
      ),
    );
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEditProfileSheet(),
    );
  }

  Widget _buildEditProfileSheet() {
    final firstNameController = TextEditingController(text: 'John');
    final lastNameController = TextEditingController(text: 'Doe');
    final emailController = TextEditingController(text: _mockUser.email);
    final phoneController = TextEditingController(text: _mockUser.phone);
    final positionController = TextEditingController(
      text: _mockUser.currentPosition,
    );
    final companyController = TextEditingController(
      text: _mockUser.currentCompany,
    );
    final bioController = TextEditingController(text: _mockUser.bio);
    final locationController = TextEditingController(text: _mockUser.location);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ATUColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ATUColors.primaryBlue.withValues(alpha: .05),
                      ATUColors.primaryGold.withValues(alpha: .05),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: ATUColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: ATUColors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Your Profile',
                            style: ATUTextStyles.h4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Update your information to stay connected',
                            style: ATUTextStyles.bodyMedium.copyWith(
                              color: ATUColors.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Photo Section
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                gradient: ATUColors.brandGradient,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: ATUColors.white,
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundColor: ATUColors.primaryBlue,
                                  child: Text(
                                    'JD',
                                    style: ATUTextStyles.h2.copyWith(
                                      color: ATUColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: ATUColors.primaryGold,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ATUColors.white,
                                    width: 3,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: ATUColors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Personal Information
                      _buildEditFormSection(
                        'Personal Information',
                        Icons.person_rounded,
                        ATUColors.primaryBlue,
                        [
                          Row(
                            children: [
                              Expanded(
                                child: ATUTextField(
                                  label: 'First Name',
                                  hint: 'Enter your first name',
                                  controller: firstNameController,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ATUTextField(
                                  label: 'Last Name',
                                  hint: 'Enter your last name',
                                  controller: lastNameController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ATUTextField(
                            label: 'Email Address',
                            hint: 'Enter your email',
                            controller: emailController,
                            enabled: false,
                            suffixIcon: Icons.lock_rounded,
                          ),
                          const SizedBox(height: 16),
                          ATUTextField(
                            label: 'Phone Number',
                            hint: 'Enter your phone number',
                            controller: phoneController,
                            prefixIcon: Icons.phone_rounded,
                          ),
                          const SizedBox(height: 16),
                          ATUTextField(
                            label: 'Location',
                            hint: 'Enter your current location',
                            controller: locationController,
                            prefixIcon: Icons.location_on_rounded,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Professional Information
                      _buildEditFormSection(
                        'Professional Information',
                        Icons.work_rounded,
                        ATUColors.success,
                        [
                          ATUTextField(
                            label: 'Current Position',
                            hint: 'Enter your job title',
                            controller: positionController,
                            prefixIcon: Icons.badge_rounded,
                          ),
                          const SizedBox(height: 16),
                          ATUTextField(
                            label: 'Company',
                            hint: 'Enter your company name',
                            controller: companyController,
                            prefixIcon: Icons.business_rounded,
                          ),
                          const SizedBox(height: 16),
                          ATUTextField(
                            label: 'Bio',
                            hint: 'Tell us about yourself',
                            controller: bioController,
                            maxLines: 4,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ATUButton(
                              text: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                              type: ATUButtonType.outline,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ATUButton(
                              text: 'Save Changes',
                              onPressed: () => _saveProfile(),
                              type: ATUButtonType.primary,
                              icon: Icons.check_rounded,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditFormSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
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
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  void _saveProfile() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: ATUColors.white),
            SizedBox(width: 12),
            Text('Profile updated successfully'),
          ],
        ),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  void _showPrivacySettings() => _showFeatureComingSoon('Privacy & Security');
  void _manageSocialLinks() => _showFeatureComingSoon('Social Links');
  void _showNotificationSettings() => _showFeatureComingSoon('Notifications');
  void _showLanguageSettings() => _showFeatureComingSoon('Language Settings');
  void _showThemeSettings() => _showFeatureComingSoon('Theme Settings');
  void _showHelpSupport() => _showFeatureComingSoon('Help & Support');
  void _sendFeedback() => _showFeatureComingSoon('Feedback');
  void _showTermsPrivacy() => _showFeatureComingSoon('Terms & Privacy');

  void _showFeatureComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: ATUColors.white),
            const SizedBox(width: 12),
            Text('$feature feature coming soon!'),
          ],
        ),
        backgroundColor: ATUColors.info,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ATUColors.error.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: ATUColors.error,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Sign Out'),
          ],
        ),
        content: const Text(
          'Are you sure you want to sign out of your account? You\'ll need to sign in again to access your profile.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: ATUTextStyles.bodyMedium.copyWith(
                color: ATUColors.grey600,
              ),
            ),
          ),
          ATUButton(
            text: 'Sign Out',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: ATUColors.white),
                      SizedBox(width: 12),
                      Text('Signed out successfully'),
                    ],
                  ),
                  backgroundColor: ATUColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            type: ATUButtonType.primary,
            size: ATUButtonSize.small,
          ),
        ],
      ),
    );
  }
}

// Enhanced User Profile Model
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String graduationYear;
  final String program;
  final String currentPosition;
  final String currentCompany;
  final String location;
  final String bio;
  final List<String> skills;
  final String linkedIn;
  final String github;
  final String website;
  final int profileCompletion;
  final int connectionsCount;
  final int eventsAttended;
  final int surveysCompleted;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.graduationYear,
    required this.program,
    required this.currentPosition,
    required this.currentCompany,
    required this.location,
    required this.bio,
    required this.skills,
    required this.linkedIn,
    required this.github,
    required this.website,
    required this.profileCompletion,
    required this.connectionsCount,
    required this.eventsAttended,
    required this.surveysCompleted,
  });
}
