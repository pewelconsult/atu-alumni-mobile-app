// lib/presentation/pages/profile/edit_profile_screen.dart
import 'package:atu_alumni_app/core/theme/app_theme.dart';
import 'package:atu_alumni_app/presentation/widgets/common/atu_button.dart';
import 'package:atu_alumni_app/presentation/widgets/common/atu_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+233 24 123 4567');
  final _positionController = TextEditingController(text: 'Software Engineer');
  final _companyController = TextEditingController(text: 'Google Ghana');
  final _bioController = TextEditingController(
    text:
        'Passionate software engineer with 4 years of experience in full-stack development.',
  );

  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _companyController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: ATUColors.primaryBlue,
        foregroundColor: ATUColors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: Text(
              'Save',
              style: ATUTextStyles.bodyMedium.copyWith(
                color: ATUColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile photo section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: ATUColors.primaryBlue,
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: ATUColors.primaryBlue.withValues(
                                alpha: .3,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'JD',
                            style: ATUTextStyles.h1.copyWith(
                              color: ATUColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _changeProfilePhoto,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ATUColors.primaryGold,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: ATUColors.white,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: ATUColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Personal Information Section
                _buildSection('Personal Information', [
                  Row(
                    children: [
                      Expanded(
                        child: ATUTextField(
                          label: 'First Name',
                          hint: 'Enter your first name',
                          controller: _firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ATUTextField(
                          label: 'Last Name',
                          hint: 'Enter your last name',
                          controller: _lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ATUTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: false, // Email usually shouldn't be editable
                  ),
                  const SizedBox(height: 20),
                  ATUTextField(
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ]),

                const SizedBox(height: 32),

                // Professional Information Section
                _buildSection('Professional Information', [
                  ATUTextField(
                    label: 'Current Position',
                    hint: 'Enter your job title',
                    controller: _positionController,
                  ),
                  const SizedBox(height: 20),
                  ATUTextField(
                    label: 'Company',
                    hint: 'Enter your company name',
                    controller: _companyController,
                  ),
                  const SizedBox(height: 20),
                  ATUTextField(
                    label: 'Bio',
                    hint: 'Tell us about yourself',
                    controller: _bioController,
                    maxLines: 4,
                  ),
                ]),

                const SizedBox(height: 40),

                // Save button
                ATUButton(
                  text: 'Save Changes',
                  onPressed: _isLoading ? null : _saveProfile,
                  type: ATUButtonType.primary,
                  isFullWidth: true,
                  isLoading: _isLoading,
                  icon: Icons.save_rounded,
                ),

                const SizedBox(height: 16),

                // Cancel button
                ATUButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                  type: ATUButtonType.outline,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  void _changeProfilePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Photo upload feature coming soon'),
        backgroundColor: ATUColors.info,
      ),
    );
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: ATUColors.success,
        ),
      );

      Navigator.of(context).pop();
    }
  }
}
