// lib/presentation/pages/jobs/jobs_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/common/atu_text_field.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  late AnimationController _filterAnimationController;

  String _selectedJobType = 'All';
  String _selectedExperience = 'All';
  String _selectedLocation = 'All';
  bool _showFilters = false;
  bool _showSearch = false;
  bool _isSearching = false;
  List<JobModel> _filteredJobs = [];

  final List<String> _jobTypes = [
    'All',
    'Full-time',
    'Part-time',
    'Contract',
    'Internship',
    'Remote',
  ];

  final List<String> _experienceLevels = [
    'All',
    'Entry Level',
    'Mid Level',
    'Senior Level',
    'Executive',
  ];

  final List<String> _locations = [
    'All',
    'Accra, Ghana',
    'Kumasi, Ghana',
    'Remote',
    'International',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _filterAnimationController = AnimationController(
      duration: ATUAnimations.medium,
      vsync: this,
    );
    _filteredJobs = _mockJobs;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_showSearch) _buildSearchSection(),
                      _buildStatsSection(),
                      if (_showFilters) _buildFilterSection(),
                      _buildTabBar(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildAllJobs(),
                            _buildSavedJobs(),
                            _buildMyApplications(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildPostJobFAB(),
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
                      'Career Opportunities',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Discover jobs from alumni network',
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
                            decoration: const BoxDecoration(
                              color: ATUColors.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_mockJobs.length} opportunities available',
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
        // Search toggle
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _showSearch ? ATUColors.primaryBlue : ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showSearch = !_showSearch;
              });
              if (_showSearch) {
                _filterAnimationController.forward();
              } else {
                _filterAnimationController.reverse();
                _searchController.clear();
                _applyFiltersAndSearch();
              }
            },
            child: Icon(
              Icons.search_rounded,
              color: _showSearch ? ATUColors.white : ATUColors.primaryBlue,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter toggle
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _showFilters ? ATUColors.primaryGold : ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            child: Icon(
              Icons.tune_rounded,
              color: _showFilters ? ATUColors.white : ATUColors.primaryGold,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Container(
            decoration: BoxDecoration(
              color: ATUColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: ATUShadows.soft,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search jobs by title, company, or skills...',
                hintStyle: ATUTextStyles.bodyMedium.copyWith(
                  color: ATUColors.grey400,
                ),
                prefixIcon: Icon(
                  _isSearching ? Icons.search_rounded : Icons.search_rounded,
                  color: _isSearching
                      ? ATUColors.primaryBlue
                      : ATUColors.grey400,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: ATUColors.grey400,
                        ),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.1, end: 0, duration: 400.ms);
  }

  Widget _buildStatsSection() {
    final totalJobs = _mockJobs.length;
    final savedJobs = _mockJobs.where((j) => j.isSaved).length;
    final appliedJobs = _mockJobs.where((j) => j.hasApplied).length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Jobs',
              totalJobs.toString(),
              Icons.work_rounded,
              ATUColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Saved',
              savedJobs.toString(),
              Icons.bookmark_rounded,
              ATUColors.primaryGold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Applied',
              appliedJobs.toString(),
              Icons.send_rounded,
              ATUColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 6),
          Text(
            value,
            style: ATUTextStyles.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: ATUTextStyles.caption.copyWith(color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ATUColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: ATUShadows.medium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Job Filters',
                        style: ATUTextStyles.h5.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ATUColors.grey900,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ATUColors.grey100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_getFilteredCount()} results',
                          style: ATUTextStyles.caption.copyWith(
                            color: ATUColors.grey700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildEnhancedFilterDropdown(
                    'Job Type',
                    _selectedJobType,
                    _jobTypes,
                    Icons.work_outline_rounded,
                    (value) => setState(() => _selectedJobType = value!),
                  ),
                  const SizedBox(height: 12),
                  _buildEnhancedFilterDropdown(
                    'Experience Level',
                    _selectedExperience,
                    _experienceLevels,
                    Icons.trending_up_rounded,
                    (value) => setState(() => _selectedExperience = value!),
                  ),
                  const SizedBox(height: 12),
                  _buildEnhancedFilterDropdown(
                    'Location',
                    _selectedLocation,
                    _locations,
                    Icons.location_on_rounded,
                    (value) => setState(() => _selectedLocation = value!),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ATUButton(
                          text: 'Apply (${_getFilteredCount()})',
                          onPressed: _applyFilters,
                          type: ATUButtonType.primary,
                          icon: Icons.check_rounded,
                          size: ATUButtonSize.small,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ATUButton(
                        text: 'Reset',
                        onPressed: _clearFilters,
                        type: ATUButtonType.outline,
                        icon: Icons.refresh_rounded,
                        size: ATUButtonSize.small,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.1, end: 0, duration: 400.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0));
  }

  Widget _buildEnhancedFilterDropdown(
    String label,
    String value,
    List<String> items,
    IconData icon,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: ATUColors.primaryBlue),
            const SizedBox(width: 8),
            Text(
              label,
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: ATUColors.grey700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: ATUColors.grey50,
            border: Border.all(color: ATUColors.grey300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              isExpanded: true,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: ATUTextStyles.bodyMedium.copyWith(
                      color: item == 'All'
                          ? ATUColors.grey500
                          : ATUColors.grey900,
                      fontWeight: item == value
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
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
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.soft,
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              gradient: ATUColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: ATUColors.primaryBlue.withValues(alpha: .3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: ATUColors.white,
            unselectedLabelColor: ATUColors.grey600,
            labelStyle: ATUTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: ATUTextStyles.bodyMedium,
            tabs: const [
              Tab(text: 'All Jobs'),
              Tab(text: 'Saved'),
              Tab(text: 'Applications'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildAllJobs() {
    return _filteredJobs.isEmpty
        ? _buildEmptyState(
            'No jobs found',
            'Try adjusting your search or filters',
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _filteredJobs.length,
            itemBuilder: (context, index) {
              return EnhancedJobCard(
                    job: _filteredJobs[index],
                    onTap: () => _showJobDetails(_filteredJobs[index]),
                    onSave: () => _saveJob(_filteredJobs[index]),
                    onApply: () => _applyToJob(_filteredJobs[index]),
                  )
                  .animate()
                  .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                  .slideX(
                    begin: 0.2,
                    end: 0,
                    delay: (index * 50).ms,
                    duration: 400.ms,
                  );
            },
          );
  }

  Widget _buildSavedJobs() {
    final savedJobs = _filteredJobs.where((job) => job.isSaved).toList();

    return Column(
      children: [
        // Saved Jobs Header
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ATUColors.primaryGold,
                ATUColors.primaryGold.withValues(alpha: .8),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ATUColors.primaryGold.withValues(alpha: .3),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.white.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.bookmark_rounded,
                  color: ATUColors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved Opportunities',
                      style: ATUTextStyles.h5.copyWith(
                        color: ATUColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${savedJobs.length} jobs saved • Apply when ready',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.white.withValues(alpha: .9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Jobs List
        Expanded(
          child: savedJobs.isEmpty
              ? _buildEmptyState(
                  'No saved jobs yet',
                  'Save jobs you\'re interested in to view them here',
                  icon: Icons.bookmark_border_rounded,
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: savedJobs.length,
                  itemBuilder: (context, index) {
                    return EnhancedJobCard(
                      job: savedJobs[index],
                      onTap: () => _showJobDetails(savedJobs[index]),
                      onSave: () => _unsaveJob(savedJobs[index]),
                      onApply: () => _applyToJob(savedJobs[index]),
                    ).animate().fadeIn(
                      delay: (index * 50).ms,
                      duration: 400.ms,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildMyApplications() {
    final appliedJobs = _filteredJobs.where((job) => job.hasApplied).toList();

    return Column(
      children: [
        // Applications Header
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: ATUColors.brandGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: ATUShadows.brand,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.white.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.work_history_rounded,
                  color: ATUColors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Applications',
                      style: ATUTextStyles.h5.copyWith(
                        color: ATUColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${appliedJobs.length} applications • Track your progress',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.white.withValues(alpha: .9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ATUColors.white.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: ATUColors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        // Applications List
        Expanded(
          child: appliedJobs.isEmpty
              ? _buildEmptyState(
                  'No applications yet',
                  'Apply to jobs to track your applications here',
                  icon: Icons.send_outlined,
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: appliedJobs.length,
                  itemBuilder: (context, index) {
                    return EnhancedJobCard(
                      job: appliedJobs[index],
                      onTap: () => _showJobDetails(appliedJobs[index]),
                      showApplicationStatus: true,
                    ).animate().fadeIn(
                      delay: (index * 50).ms,
                      duration: 400.ms,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String title, String subtitle, {IconData? icon}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ATUColors.grey100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.work_off_rounded,
              size: 48,
              color: ATUColors.grey400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: ATUTextStyles.h5.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ATUButton(
            text: 'Refresh',
            onPressed: () => setState(() {}),
            type: ATUButtonType.outline,
            icon: Icons.refresh_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildPostJobFAB() {
    return FloatingActionButton.extended(
      onPressed: _postJob,
      backgroundColor: ATUColors.primaryGold,
      foregroundColor: ATUColors.white,
      elevation: 6,
      icon: const Icon(Icons.add_rounded),
      label: Text(
        'Post Job',
        style: ATUTextStyles.buttonTextSmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    ).animate().scale(delay: 800.ms);
  }

  // Helper Methods
  void _onSearchChanged(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
      _applyFiltersAndSearch();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _applyFiltersAndSearch();
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedJobType = 'All';
      _selectedExperience = 'All';
      _selectedLocation = 'All';
      _applyFiltersAndSearch();
    });
  }

  void _applyFilters() {
    setState(() {
      _showFilters = false;
      _applyFiltersAndSearch();
    });
  }

  void _applyFiltersAndSearch() {
    setState(() {
      _filteredJobs = _mockJobs.where((job) {
        // Search filter
        final searchQuery = _searchController.text.toLowerCase();
        final matchesSearch =
            searchQuery.isEmpty ||
            job.title.toLowerCase().contains(searchQuery) ||
            job.company.toLowerCase().contains(searchQuery) ||
            job.description.toLowerCase().contains(searchQuery) ||
            job.requirements.any(
              (req) => req.toLowerCase().contains(searchQuery),
            );

        // Other filters
        final matchesType =
            _selectedJobType == 'All' || job.type == _selectedJobType;
        final matchesExperience =
            _selectedExperience == 'All' ||
            job.experienceLevel == _selectedExperience;
        final matchesLocation =
            _selectedLocation == 'All' || job.location == _selectedLocation;

        return matchesSearch &&
            matchesType &&
            matchesExperience &&
            matchesLocation;
      }).toList();
    });
  }

  int _getFilteredCount() {
    return _mockJobs.where((job) {
      final matchesType =
          _selectedJobType == 'All' || job.type == _selectedJobType;
      final matchesExperience =
          _selectedExperience == 'All' ||
          job.experienceLevel == _selectedExperience;
      final matchesLocation =
          _selectedLocation == 'All' || job.location == _selectedLocation;
      return matchesType && matchesExperience && matchesLocation;
    }).length;
  }

  void _showJobDetails(JobModel job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildJobDetailsSheet(job),
    );
  }

  Widget _buildJobDetailsSheet(JobModel job) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.9,
      minChildSize: 0.4,
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

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Job header
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              job.companyColor.withValues(alpha: .1),
                              job.companyColor.withValues(alpha: .05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: job.companyColor.withValues(alpha: .3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        job.companyColor,
                                        job.companyColor.withValues(alpha: .7),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.business_rounded,
                                    color: ATUColors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.title,
                                        style: ATUTextStyles.h4.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        job.company,
                                        style: ATUTextStyles.bodyLarge.copyWith(
                                          color: job.companyColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        job.location,
                                        style: ATUTextStyles.bodyMedium
                                            .copyWith(color: ATUColors.grey600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                _buildEnhancedJobTag(
                                  job.type,
                                  ATUColors.primaryBlue,
                                ),
                                const SizedBox(width: 8),
                                _buildEnhancedJobTag(
                                  job.experienceLevel,
                                  ATUColors.success,
                                ),
                                const SizedBox(width: 8),
                                _buildEnhancedJobTag(
                                  job.salary,
                                  ATUColors.primaryGold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Job description
                      _buildDetailSection(
                        'Job Description',
                        Icons.description_rounded,
                        ATUColors.primaryBlue,
                        [
                          Text(
                            job.description,
                            style: ATUTextStyles.bodyMedium.copyWith(
                              color: ATUColors.grey600,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Requirements
                      _buildDetailSection(
                        'Requirements',
                        Icons.checklist_rounded,
                        ATUColors.success,
                        job.requirements
                            .map(
                              (req) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: ATUColors.success,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        req,
                                        style: ATUTextStyles.bodyMedium
                                            .copyWith(
                                              color: ATUColors.grey600,
                                              height: 1.4,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      // Posted by section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ATUColors.primaryBlue.withValues(alpha: .05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ATUColors.primaryBlue.withValues(alpha: .2),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: ATUColors.primaryBlue,
                              child: Text(
                                job.postedBy.substring(0, 1).toUpperCase(),
                                style: ATUTextStyles.bodyMedium.copyWith(
                                  color: ATUColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Posted by Alumni',
                                    style: ATUTextStyles.caption.copyWith(
                                      color: ATUColors.grey500,
                                    ),
                                  ),
                                  Text(
                                    job.postedBy,
                                    style: ATUTextStyles.bodyMedium.copyWith(
                                      color: ATUColors.primaryBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.verified_rounded,
                              color: ATUColors.success,
                              size: 20,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ATUButton(
                              text: job.hasApplied ? 'Applied ✓' : 'Apply Now',
                              onPressed: job.hasApplied
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                      _applyToJob(job);
                                    },
                              type: job.hasApplied
                                  ? ATUButtonType.outline
                                  : ATUButtonType.primary,
                              icon: job.hasApplied
                                  ? Icons.check_rounded
                                  : Icons.send_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          ATUButton(
                            text: '',
                            onPressed: () {
                              Navigator.pop(context);
                              if (job.isSaved) {
                                _unsaveJob(job);
                              } else {
                                _saveJob(job);
                              }
                            },
                            type: ATUButtonType.outline,
                            icon: job.isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
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

  Widget _buildDetailSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ATUColors.grey50,
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
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildEnhancedJobTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withValues(alpha: .7)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: ATUTextStyles.caption.copyWith(
          color: ATUColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _postJob() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildPostJobSheet(),
    );
  }

  Widget _buildPostJobSheet() {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final salaryController = TextEditingController();
    final descriptionController = TextEditingController();
    final requirementsController = TextEditingController();
    String selectedJobType = 'Full-time';
    String selectedExperienceLevel = 'Mid Level';

    return StatefulBuilder(
      builder: (context, setModalState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.9,
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
                          ATUColors.primaryGold.withValues(alpha: .1),
                          ATUColors.primaryBlue.withValues(alpha: .05),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ATUColors.primaryGold,
                                ATUColors.primaryGold.withValues(alpha: .8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.work_rounded,
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
                                'Post a Job Opportunity',
                                style: ATUTextStyles.h4.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Help fellow alumni find great opportunities',
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
                          // Job Title
                          _buildPostJobFormSection(
                            'Job Title *',
                            ATUTextField(
                              controller: titleController,
                              label: '',
                              hint: 'e.g. Senior Software Engineer',
                            ),
                          ),

                          // Company
                          _buildPostJobFormSection(
                            'Company *',
                            ATUTextField(
                              controller: companyController,
                              label: '',
                              hint: 'Company name',
                            ),
                          ),

                          // Job Type and Experience Level
                          Row(
                            children: [
                              Expanded(
                                child: _buildPostJobFormSection(
                                  'Job Type *',
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ATUColors.grey50,
                                      border: Border.all(
                                        color: ATUColors.grey300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedJobType,
                                        onChanged: (value) {
                                          setModalState(() {
                                            selectedJobType = value!;
                                          });
                                        },
                                        isExpanded: true,
                                        items: _jobTypes
                                            .where((type) => type != 'All')
                                            .map((type) {
                                              return DropdownMenuItem<String>(
                                                value: type,
                                                child: Text(
                                                  type,
                                                  style:
                                                      ATUTextStyles.bodyMedium,
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildPostJobFormSection(
                                  'Experience *',
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ATUColors.grey50,
                                      border: Border.all(
                                        color: ATUColors.grey300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedExperienceLevel,
                                        onChanged: (value) {
                                          setModalState(() {
                                            selectedExperienceLevel = value!;
                                          });
                                        },
                                        isExpanded: true,
                                        items: _experienceLevels
                                            .where((exp) => exp != 'All')
                                            .map((exp) {
                                              return DropdownMenuItem<String>(
                                                value: exp,
                                                child: Text(
                                                  exp,
                                                  style:
                                                      ATUTextStyles.bodyMedium,
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Location and Salary
                          Row(
                            children: [
                              Expanded(
                                child: _buildPostJobFormSection(
                                  'Location *',
                                  ATUTextField(
                                    controller: locationController,
                                    label: '',
                                    hint: 'e.g. Accra, Ghana',
                                    prefixIcon: Icons.location_on_rounded,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildPostJobFormSection(
                                  'Salary Range',
                                  ATUTextField(
                                    controller: salaryController,
                                    label: '',
                                    hint: 'e.g. ₵5,000 - ₵8,000',
                                    prefixIcon: Icons.payments_rounded,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Description
                          _buildPostJobFormSection(
                            'Job Description *',
                            ATUTextField(
                              controller: descriptionController,
                              label: '',
                              hint:
                                  'Describe the role, responsibilities, and what you\'re looking for...',
                              maxLines: 4,
                            ),
                          ),

                          // Requirements
                          _buildPostJobFormSection(
                            'Requirements *',
                            ATUTextField(
                              controller: requirementsController,
                              label: '',
                              hint:
                                  'List key requirements (separate with new lines)',
                              maxLines: 4,
                            ),
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
                                  text: 'Post Job',
                                  onPressed: () {
                                    _submitJobPost(
                                      titleController.text,
                                      companyController.text,
                                      locationController.text,
                                      salaryController.text,
                                      descriptionController.text,
                                      requirementsController.text,
                                      selectedJobType,
                                      selectedExperienceLevel,
                                    );
                                    Navigator.pop(context);
                                  },
                                  type: ATUButtonType.primary,
                                  icon: Icons.publish_rounded,
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
      },
    );
  }

  Widget _buildPostJobFormSection(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ATUTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  void _submitJobPost(
    String title,
    String company,
    String location,
    String salary,
    String description,
    String requirements,
    String jobType,
    String experienceLevel,
  ) {
    if (title.isEmpty ||
        company.isEmpty ||
        location.isEmpty ||
        description.isEmpty ||
        requirements.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: ATUColors.error,
        ),
      );
      return;
    }

    // Here you would typically send the data to your backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Job "$title" posted successfully!')),
          ],
        ),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'View',
          textColor: ATUColors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  void _saveJob(JobModel job) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.bookmark, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('${job.title} saved to your list')),
          ],
        ),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _unsaveJob(JobModel job) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.bookmark_remove, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('${job.title} removed from saved jobs')),
          ],
        ),
        backgroundColor: ATUColors.warning,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _applyToJob(JobModel job) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.send, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Application submitted for ${job.title}')),
          ],
        ),
        backgroundColor: ATUColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'Track',
          textColor: ATUColors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}

// Enhanced Job Card Widget
class EnhancedJobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final VoidCallback? onApply;
  final bool showApplicationStatus;

  const EnhancedJobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onSave,
    this.onApply,
    this.showApplicationStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: ATUColors.cardGradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: job.hasApplied
                  ? ATUColors.success.withValues(alpha: .3)
                  : job.isSaved
                  ? ATUColors.primaryGold.withValues(alpha: .3)
                  : ATUColors.grey200,
              width: job.hasApplied || job.isSaved ? 2 : 1,
            ),
            boxShadow: ATUShadows.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Header with company info and save button
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          job.companyColor,
                          job.companyColor.withValues(alpha: .7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: job.companyColor.withValues(alpha: .3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.business_rounded,
                      color: ATUColors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: ATUTextStyles.h6.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ATUColors.grey900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.company,
                          style: ATUTextStyles.bodyMedium.copyWith(
                            color: job.companyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onSave != null)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: job.isSaved
                            ? ATUColors.primaryGold.withValues(alpha: .1)
                            : ATUColors.grey100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: onSave,
                        child: Icon(
                          job.isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: job.isSaved
                              ? ATUColors.primaryGold
                              : ATUColors.grey400,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Enhanced Job details
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.grey50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ATUColors.grey200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildJobDetailItem(
                        Icons.location_on_rounded,
                        job.location,
                        ATUColors.info,
                      ),
                    ),
                    Container(width: 1, height: 20, color: ATUColors.grey300),
                    Expanded(
                      child: _buildJobDetailItem(
                        Icons.work_outline_rounded,
                        job.type,
                        ATUColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Enhanced Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildEnhancedJobTag(job.experienceLevel, ATUColors.success),
                  _buildEnhancedJobTag(job.salary, ATUColors.primaryGold),
                  if (showApplicationStatus && job.hasApplied)
                    _buildStatusTag(job.applicationStatus),
                ],
              ),

              const SizedBox(height: 16),

              // Job description preview with better styling
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ATUColors.grey200),
                ),
                child: Text(
                  job.description,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.grey600,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 16),

              // Enhanced Posted by alumni section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ATUColors.primaryBlue.withValues(alpha: .05),
                      ATUColors.primaryGold.withValues(alpha: .05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ATUColors.primaryBlue.withValues(alpha: .2),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: ATUColors.primaryBlue,
                      child: Text(
                        job.postedBy.substring(0, 1).toUpperCase(),
                        style: ATUTextStyles.bodySmall.copyWith(
                          color: ATUColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Posted by Alumni',
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.grey500,
                            ),
                          ),
                          Text(
                            job.postedBy,
                            style: ATUTextStyles.bodySmall.copyWith(
                              color: ATUColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ATUColors.success.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        color: ATUColors.success,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Enhanced Action buttons
              if (!showApplicationStatus || !job.hasApplied)
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'View Details',
                        onPressed: onTap,
                        type: ATUButtonType.outline,
                        size: ATUButtonSize.small,
                        icon: Icons.info_outline_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ATUButton(
                        text: job.hasApplied ? 'Applied ✓' : 'Apply Now',
                        onPressed: job.hasApplied ? null : onApply,
                        type: job.hasApplied
                            ? ATUButtonType.outline
                            : ATUButtonType.primary,
                        size: ATUButtonSize.small,
                        icon: job.hasApplied
                            ? Icons.check_rounded
                            : Icons.send_rounded,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'View Application',
                        onPressed: onTap,
                        type: ATUButtonType.outline,
                        size: ATUButtonSize.small,
                        icon: Icons.description_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ATUButton(
                        text: 'Track Status',
                        onPressed: () {},
                        type: ATUButtonType.primary,
                        size: ATUButtonSize.small,
                        icon: Icons.track_changes_rounded,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobDetailItem(IconData icon, String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: ATUTextStyles.bodySmall.copyWith(
              color: ATUColors.grey600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedJobTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: .1), color.withValues(alpha: .05)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Text(
        text,
        style: ATUTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':
        color = ATUColors.warning;
        break;
      case 'under review':
        color = ATUColors.info;
        break;
      case 'interview scheduled':
        color = ATUColors.success;
        break;
      case 'rejected':
        color = ATUColors.error;
        break;
      case 'accepted':
        color = ATUColors.success;
        break;
      default:
        color = ATUColors.grey500;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withValues(alpha: .7)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: ATUColors.white),
          const SizedBox(width: 6),
          Text(
            status,
            style: ATUTextStyles.caption.copyWith(
              color: ATUColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Job Model
class JobModel {
  final String title;
  final String company;
  final String location;
  final String type;
  final String experienceLevel;
  final String salary;
  final String description;
  final List<String> requirements;
  final Color companyColor;
  final bool isSaved;
  final bool hasApplied;
  final String applicationStatus;
  final String postedBy;

  JobModel({
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.experienceLevel,
    required this.salary,
    required this.description,
    required this.requirements,
    required this.companyColor,
    this.isSaved = false,
    this.hasApplied = false,
    this.applicationStatus = 'Pending',
    required this.postedBy,
  });
}

// Enhanced Mock Jobs Data
final List<JobModel> _mockJobs = [
  JobModel(
    title: 'Senior Software Engineer',
    company: 'Google Ghana',
    location: 'Accra, Ghana',
    type: 'Full-time',
    experienceLevel: 'Senior Level',
    salary: '₵8,000 - ₵12,000',
    description:
        'We are looking for a Senior Software Engineer to join our team in Accra. You will be responsible for designing and developing scalable software solutions that impact millions of users across Africa.',
    requirements: [
      'Bachelor\'s degree in Computer Science or related field',
      '5+ years of experience in software development',
      'Proficiency in Python, Java, or Go programming languages',
      'Experience with cloud platforms (GCP preferred)',
      'Strong problem-solving and analytical skills',
      'Experience with microservices architecture',
      'Knowledge of containerization (Docker, Kubernetes)',
    ],
    companyColor: ATUColors.info,
    isSaved: true,
    hasApplied: true,
    applicationStatus: 'Under Review',
    postedBy: 'Sarah Johnson (Class of 2020)',
  ),
  JobModel(
    title: 'Product Manager',
    company: 'MTN Ghana',
    location: 'Accra, Ghana',
    type: 'Full-time',
    experienceLevel: 'Mid Level',
    salary: '₵6,000 - ₵9,000',
    description:
        'Join our product team to help shape the future of telecommunications in Ghana. Lead product development from ideation to launch, working with cross-functional teams.',
    requirements: [
      'Bachelor\'s degree in Business, Engineering, or related field',
      '3+ years of product management experience',
      'Experience with agile methodologies and product development lifecycle',
      'Strong analytical and communication skills',
      'Understanding of telecommunications industry is a plus',
      'Data-driven decision making experience',
    ],
    companyColor: ATUColors.primaryGold,
    isSaved: false,
    hasApplied: false,
    postedBy: 'Michael Asante (Class of 2019)',
  ),
  JobModel(
    title: 'UX/UI Designer',
    company: 'Flutterwave',
    location: 'Remote',
    type: 'Remote',
    experienceLevel: 'Mid Level',
    salary: '\$3,000 - \$4,500',
    description:
        'Create exceptional user experiences for our fintech products used by millions across Africa. Work with a distributed team to design intuitive interfaces.',
    requirements: [
      'Bachelor\'s degree in Design, HCI, or related field',
      '3+ years of UX/UI design experience',
      'Proficiency in Figma, Sketch, or similar design tools',
      'Experience with user research and usability testing',
      'Portfolio demonstrating strong design skills',
      'Understanding of fintech industry trends',
    ],
    companyColor: ATUColors.success,
    isSaved: true,
    hasApplied: false,
    postedBy: 'Emma Wilson (Class of 2021)',
  ),
  JobModel(
    title: 'Data Analyst Intern',
    company: 'Vodafone Ghana',
    location: 'Accra, Ghana',
    type: 'Internship',
    experienceLevel: 'Entry Level',
    salary: '₵1,500 - ₵2,000',
    description:
        'Join our data team as an intern and gain hands-on experience with big data analytics in the telecommunications industry. Learn from experienced professionals.',
    requirements: [
      'Currently pursuing a degree in Statistics, Mathematics, or related field',
      'Basic knowledge of SQL and Excel',
      'Familiarity with Python or R is a plus',
      'Strong analytical thinking and attention to detail',
      'Excellent communication skills',
      'Eager to learn and grow',
    ],
    companyColor: ATUColors.error,
    isSaved: false,
    hasApplied: true,
    applicationStatus: 'Interview Scheduled',
    postedBy: 'Kwame Osei (Class of 2018)',
  ),
  JobModel(
    title: 'Marketing Specialist',
    company: 'Jumia Ghana',
    location: 'Accra, Ghana',
    type: 'Full-time',
    experienceLevel: 'Mid Level',
    salary: '₵4,500 - ₵6,500',
    description:
        'Drive digital marketing campaigns for Ghana\'s leading e-commerce platform. Develop strategies to increase brand awareness and customer acquisition.',
    requirements: [
      'Bachelor\'s degree in Marketing, Business, or related field',
      '2+ years of digital marketing experience',
      'Experience with social media marketing and advertising',
      'Knowledge of Google Analytics and marketing tools',
      'Creative thinking and campaign development skills',
      'Understanding of e-commerce landscape',
    ],
    companyColor: ATUColors.primaryBlue,
    isSaved: true,
    hasApplied: false,
    postedBy: 'Jennifer Lee (Class of 2017)',
  ),
  JobModel(
    title: 'Business Development Executive',
    company: 'Standard Chartered Bank',
    location: 'Accra, Ghana',
    type: 'Full-time',
    experienceLevel: 'Senior Level',
    salary: '₵10,000 - ₵15,000',
    description:
        'Lead business development initiatives for our corporate banking division. Build relationships with key clients and drive revenue growth.',
    requirements: [
      'Bachelor\'s degree in Business, Finance, or related field',
      '5+ years of business development experience',
      'Strong relationship building and negotiation skills',
      'Experience in banking or financial services',
      'Excellent presentation and communication skills',
      'Track record of meeting sales targets',
    ],
    companyColor: ATUColors.primaryGold,
    isSaved: false,
    hasApplied: true,
    applicationStatus: 'Pending',
    postedBy: 'David Mensah (Class of 2016)',
  ),
];
