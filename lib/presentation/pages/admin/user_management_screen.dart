// lib/presentation/pages/admin/user_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/user_model.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/common/atu_text_field.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  String _selectedRole = 'All';
  String _selectedStatus = 'All';
  bool _showFilters = false;

  final List<String> _roles = ['All', 'Alumni', 'Admin', 'Staff'];
  final List<String> _statuses = [
    'All',
    'Active',
    'Inactive',
    'Pending Verification',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchAndFilters(),
              if (_showFilters) _buildFilterSection(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAllUsersTab(),
                    _buildPendingVerificationTab(),
                    _buildUserAnalyticsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddUserDialog,
        backgroundColor: ATUColors.primaryGold,
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Add User'),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Management',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    Text(
                      'Manage alumni accounts and permissions',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ATUColors.grey400.withValues(alpha: .2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.manage_accounts_rounded,
                  color: ATUColors.primaryBlue,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0, duration: 600.ms);
  }

  Widget _buildSearchAndFilters() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ATUTextField(
                      label: '',
                      hint: 'Search users by name, email, or student ID...',
                      controller: _searchController,
                      prefixIcon: Icons.search_rounded,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: _showFilters
                          ? ATUColors.primaryBlue
                          : ATUColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ATUColors.primaryBlue,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _showFilters = !_showFilters;
                        });
                      },
                      icon: Icon(
                        Icons.tune_rounded,
                        color: _showFilters
                            ? ATUColors.white
                            : ATUColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildFilterSection() {
    return Container(
          margin: const EdgeInsets.all(24),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: ATUTextStyles.h4.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ATUColors.grey900,
                    ),
                  ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: Text(
                      'Clear All',
                      style: ATUTextStyles.bodySmall.copyWith(
                        color: ATUColors.primaryGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildFilterDropdown('User Role', _selectedRole, _roles, (value) {
                setState(() => _selectedRole = value!);
              }),
              const SizedBox(height: 12),
              _buildFilterDropdown('Status', _selectedStatus, _statuses, (
                value,
              ) {
                setState(() => _selectedStatus = value!);
              }),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ATUButton(
                      text: 'Apply Filters',
                      onPressed: _applyFilters,
                      type: ATUButtonType.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.1, end: 0, duration: 400.ms);
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ATUTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: ATUColors.grey700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: ATUColors.grey300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: ATUTextStyles.bodyMedium),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: ATUColors.grey100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: ATUColors.primaryBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: ATUColors.white,
            unselectedLabelColor: ATUColors.grey600,
            labelStyle: ATUTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'All Users'),
              Tab(text: 'Pending'),
              Tab(text: 'Analytics'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildAllUsersTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _mockUsers.length,
      itemBuilder: (context, index) {
        return UserCard(
              user: _mockUsers[index],
              onTap: () => _showUserDetails(_mockUsers[index]),
              onEdit: () => _editUser(_mockUsers[index]),
              onDelete: () => _deleteUser(_mockUsers[index]),
              onToggleStatus: () => _toggleUserStatus(_mockUsers[index]),
            )
            .animate()
            .fadeIn(delay: (index * 100).ms, duration: 400.ms)
            .slideX(
              begin: 0.2,
              end: 0,
              delay: (index * 100).ms,
              duration: 400.ms,
            );
      },
    );
  }

  Widget _buildPendingVerificationTab() {
    final pendingUsers = _mockUsers.where((user) => !user.isVerified).toList();

    if (pendingUsers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user_rounded,
              size: 64,
              color: ATUColors.grey400,
            ),
            SizedBox(height: 16),
            Text(
              'No Pending Verifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ATUColors.grey600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'All users are verified',
              style: TextStyle(color: ATUColors.grey500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: pendingUsers.length,
      itemBuilder: (context, index) {
        return PendingVerificationCard(
          user: pendingUsers[index],
          onApprove: () => _approveUser(pendingUsers[index]),
          onReject: () => _rejectUser(pendingUsers[index]),
          onViewDetails: () => _showUserDetails(pendingUsers[index]),
        );
      },
    );
  }

  Widget _buildUserAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // User statistics
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  'Total Users',
                  '2,847',
                  ATUColors.primaryBlue,
                  Icons.people_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnalyticsCard(
                  'Verified',
                  '2,651',
                  ATUColors.success,
                  Icons.verified_user_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  'Active Users',
                  '1,943',
                  ATUColors.info,
                  Icons.online_prediction_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnalyticsCard(
                  'New This Month',
                  '127',
                  ATUColors.primaryGold,
                  Icons.trending_up_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Registration trends chart
          Container(
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
                  'User Registration Trends',
                  style: ATUTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ATUColors.grey900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'New user registrations over the last 6 months',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(height: 200, child: _buildRegistrationChart()),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // User roles distribution
          Container(
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
                  'User Roles Distribution',
                  style: ATUTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ATUColors.grey900,
                  ),
                ),
                const SizedBox(height: 20),
                _buildRoleDistribution(
                  'Alumni',
                  2794,
                  98.1,
                  ATUColors.primaryBlue,
                ),
                _buildRoleDistribution('Admin', 35, 1.2, ATUColors.primaryGold),
                _buildRoleDistribution('Staff', 18, 0.7, ATUColors.success),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.trending_up_rounded, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: ATUTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          Text(
            title,
            style: ATUTextStyles.bodySmall.copyWith(
              color: ATUColors.grey600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationChart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildChartBar('Jul', 45, ATUColors.primaryBlue),
        _buildChartBar('Aug', 67, ATUColors.primaryBlue),
        _buildChartBar('Sep', 89, ATUColors.success),
        _buildChartBar('Oct', 123, ATUColors.success),
        _buildChartBar('Nov', 156, ATUColors.primaryGold),
        _buildChartBar('Dec', 127, ATUColors.info),
      ],
    );
  }

  Widget _buildChartBar(String month, int count, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          count.toString(),
          style: ATUTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: ATUColors.grey700,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 24,
          height: (count / 200) * 150, // Scale to max height 150
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
        ),
      ],
    );
  }

  Widget _buildRoleDistribution(
    String role,
    int count,
    double percentage,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                role,
                style: ATUTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ATUColors.grey700,
                ),
              ),
              Text(
                '$count (${percentage.toStringAsFixed(1)}%)',
                style: ATUTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: ATUColors.grey200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedRole = 'All';
      _selectedStatus = 'All';
    });
  }

  void _applyFilters() {
    setState(() {
      _showFilters = false;
    });
  }

  void _showUserDetails(UserModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildUserDetailsSheet(user),
    );
  }

  Widget _buildUserDetailsSheet(UserModel user) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: ATUColors.grey300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // User header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: ATUColors.primaryBlue,
                        child: Text(
                          user.initials,
                          style: ATUTextStyles.bodyLarge.copyWith(
                            color: ATUColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: ATUTextStyles.h4.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: ATUTextStyles.bodyMedium.copyWith(
                                color: ATUColors.grey600,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getRoleColor(
                                      user.role,
                                    ).withValues(alpha: .1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _getRoleLabel(user.role),
                                    style: ATUTextStyles.caption.copyWith(
                                      color: _getRoleColor(user.role),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: user.isVerified
                                        ? ATUColors.success.withValues(
                                            alpha: .1,
                                          )
                                        : ATUColors.warning.withValues(
                                            alpha: .1,
                                          ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    user.isVerified ? 'Verified' : 'Pending',
                                    style: ATUTextStyles.caption.copyWith(
                                      color: user.isVerified
                                          ? ATUColors.success
                                          : ATUColors.warning,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // User details
                  _buildDetailSection('Account Information', [
                    _buildDetailItem('User ID', user.id),
                    _buildDetailItem('Email', user.email),
                    _buildDetailItem('Role', _getRoleLabel(user.role)),
                    _buildDetailItem('Created', _formatDate(user.createdAt)),
                    _buildDetailItem(
                      'Last Login',
                      user.lastLoginAt != null
                          ? _formatDate(user.lastLoginAt!)
                          : 'Never',
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ATUButton(
                          text: 'Edit User',
                          onPressed: () {
                            Navigator.pop(context);
                            _editUser(user);
                          },
                          type: ATUButtonType.primary,
                          icon: Icons.edit_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ATUButton(
                        text: user.isVerified ? 'Suspend' : 'Verify',
                        onPressed: () {
                          Navigator.pop(context);
                          _toggleUserStatus(user);
                        },
                        type: ATUButtonType.outline,
                        icon: user.isVerified
                            ? Icons.block_rounded
                            : Icons.verified_user_rounded,
                        customColor: user.isVerified
                            ? ATUColors.warning
                            : ATUColors.success,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ATUTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: ATUColors.grey900,
          ),
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: ATUColors.grey600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: ATUTextStyles.bodyMedium.copyWith(
                color: ATUColors.grey900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(context: context, builder: (context) => const AddUserDialog());
  }

  void _editUser(UserModel user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing user: ${user.fullName}'),
        backgroundColor: ATUColors.info,
      ),
    );
  }

  void _deleteUser(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ATUColors.error.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.warning_rounded, color: ATUColors.error),
            ),
            const SizedBox(width: 12),
            const Text('Delete User'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete ${user.fullName}? This action cannot be undone.',
        ),
        actions: [
          ATUButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(context).pop(),
            type: ATUButtonType.outline,
          ),
          const SizedBox(width: 12),
          ATUButton(
            text: 'Delete',
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User ${user.fullName} deleted'),
                  backgroundColor: ATUColors.error,
                ),
              );
            },
            type: ATUButtonType.primary,
            customColor: ATUColors.error,
          ),
        ],
      ),
    );
  }

  void _toggleUserStatus(UserModel user) {
    final action = user.isVerified ? 'suspended' : 'verified';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User ${user.fullName} $action'),
        backgroundColor: user.isVerified
            ? ATUColors.warning
            : ATUColors.success,
      ),
    );
  }

  void _approveUser(UserModel user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User ${user.fullName} approved'),
        backgroundColor: ATUColors.success,
      ),
    );
  }

  void _rejectUser(UserModel user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User ${user.fullName} rejected'),
        backgroundColor: ATUColors.error,
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.alumni:
        return ATUColors.primaryBlue;
      case UserRole.admin:
        return ATUColors.primaryGold;
      case UserRole.staff:
        return ATUColors.success;
    }
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.alumni:
        return 'Alumni';
      case UserRole.admin:
        return 'Admin';
      case UserRole.staff:
        return 'Staff';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// User Card Widget
class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleStatus;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ATUColors.grey400.withValues(alpha: .1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: _getRoleColor(user.role),
                child: Text(
                  user.initials,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: ATUTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ATUColors.grey900,
                      ),
                    ),
                    Text(
                      user.email,
                      style: ATUTextStyles.bodySmall.copyWith(
                        color: ATUColors.grey600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getRoleColor(
                              user.role,
                            ).withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getRoleLabel(user.role),
                            style: ATUTextStyles.caption.copyWith(
                              color: _getRoleColor(user.role),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: user.isVerified
                                ? ATUColors.success.withValues(alpha: .1)
                                : ATUColors.warning.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            user.isVerified ? 'Verified' : 'Pending',
                            style: ATUTextStyles.caption.copyWith(
                              color: user.isVerified
                                  ? ATUColors.success
                                  : ATUColors.warning,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      onEdit?.call();
                      break;
                    case 'status':
                      onToggleStatus?.call();
                      break;
                    case 'delete':
                      onDelete?.call();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit User')),
                  PopupMenuItem(
                    value: 'status',
                    child: Text(
                      user.isVerified ? 'Suspend User' : 'Verify User',
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete User'),
                  ),
                ],
                child: const Icon(
                  Icons.more_vert_rounded,
                  color: ATUColors.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.alumni:
        return ATUColors.primaryBlue;
      case UserRole.admin:
        return ATUColors.primaryGold;
      case UserRole.staff:
        return ATUColors.success;
    }
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.alumni:
        return 'Alumni';
      case UserRole.admin:
        return 'Admin';
      case UserRole.staff:
        return 'Staff';
    }
  }
}

// Pending Verification Card
class PendingVerificationCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onViewDetails;

  const PendingVerificationCard({
    super.key,
    required this.user,
    this.onApprove,
    this.onReject,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ATUColors.warning.withValues(alpha: .3)),
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: ATUColors.warning,
                child: Text(
                  user.initials,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: ATUTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ATUColors.grey900,
                      ),
                    ),
                    Text(
                      user.email,
                      style: ATUTextStyles.bodySmall.copyWith(
                        color: ATUColors.grey600,
                      ),
                    ),
                    Text(
                      'Registered ${_formatDate(user.createdAt)}',
                      style: ATUTextStyles.caption.copyWith(
                        color: ATUColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ATUColors.warning.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Pending',
                  style: ATUTextStyles.caption.copyWith(
                    color: ATUColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ATUButton(
                  text: 'View Details',
                  onPressed: onViewDetails,
                  type: ATUButtonType.outline,
                  size: ATUButtonSize.small,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ATUButton(
                  text: 'Reject',
                  onPressed: onReject,
                  type: ATUButtonType.outline,
                  size: ATUButtonSize.small,
                  customColor: ATUColors.error,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ATUButton(
                  text: 'Approve',
                  onPressed: onApprove,
                  type: ATUButtonType.primary,
                  size: ATUButtonSize.small,
                  customColor: ATUColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Add User Dialog
class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentIdController = TextEditingController();

  UserRole _selectedRole = UserRole.alumni;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New User',
              style: ATUTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ATUTextField(
                              label: 'First Name',
                              hint: 'Enter first name',
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ATUTextField(
                              label: 'Last Name',
                              hint: 'Enter last name',
                              controller: _lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      ATUTextField(
                        label: 'Email',
                        hint: 'Enter email address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      if (_selectedRole == UserRole.alumni)
                        ATUTextField(
                          label: 'Student ID',
                          hint: 'Enter student ID',
                          controller: _studentIdController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter student ID';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Role',
                            style: ATUTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ATUColors.grey700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: ATUColors.grey300),
                              borderRadius: BorderRadius.circular(12),
                              color: ATUColors.grey50,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<UserRole>(
                                value: _selectedRole,
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRole = value!;
                                  });
                                },
                                items: UserRole.values.map((role) {
                                  return DropdownMenuItem<UserRole>(
                                    value: role,
                                    child: Text(_getRoleLabel(role)),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ATUButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(),
                    type: ATUButtonType.outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ATUButton(
                    text: 'Add User',
                    onPressed: _isLoading ? null : _addUser,
                    type: ATUButtonType.primary,
                    isLoading: _isLoading,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.alumni:
        return 'Alumni';
      case UserRole.admin:
        return 'Admin';
      case UserRole.staff:
        return 'Staff';
    }
  }

  void _addUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User added successfully'),
            backgroundColor: ATUColors.success,
          ),
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
}

// Mock users data
final List<UserModel> _mockUsers = [
  UserModel(
    id: '1',
    email: 'john.doe@example.com',
    firstName: 'John',
    lastName: 'Doe',
    role: UserRole.alumni,
    isVerified: true,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    lastLoginAt: DateTime.now().subtract(const Duration(hours: 2)),
    preferences: UserPreferences(),
  ),
  UserModel(
    id: '2',
    email: 'sarah.johnson@example.com',
    firstName: 'Sarah',
    lastName: 'Johnson',
    role: UserRole.alumni,
    isVerified: true,
    createdAt: DateTime.now().subtract(const Duration(days: 45)),
    lastLoginAt: DateTime.now().subtract(const Duration(days: 1)),
    preferences: UserPreferences(),
  ),
  UserModel(
    id: '3',
    email: 'admin@atu.edu.gh',
    firstName: 'Peter',
    lastName: 'Nyanor',
    role: UserRole.admin,
    isVerified: true,
    createdAt: DateTime.now().subtract(const Duration(days: 365)),
    lastLoginAt: DateTime.now().subtract(const Duration(minutes: 30)),
    preferences: UserPreferences(),
  ),
  UserModel(
    id: '4',
    email: 'pending.user@example.com',
    firstName: 'Pending',
    lastName: 'User',
    role: UserRole.alumni,
    isVerified: false,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    preferences: UserPreferences(),
  ),
];
