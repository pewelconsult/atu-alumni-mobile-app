// lib/presentation/pages/directory/alumni_directory.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';

class AlumniDirectory extends StatefulWidget {
  const AlumniDirectory({super.key});

  @override
  State<AlumniDirectory> createState() => _AlumniDirectoryState();
}

class _AlumniDirectoryState extends State<AlumniDirectory>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  late AnimationController _filterAnimationController;

  String _selectedYear = 'All';
  String _selectedProgram = 'All';
  String _selectedLocation = 'All';
  bool _showFilters = false;
  bool _isSearching = false;
  List<AlumniModel> _filteredAlumni = [];

  final List<String> _graduationYears = [
    'All',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
  ];

  final List<String> _programs = [
    'All',
    'Computer Science',
    'Engineering',
    'Business Administration',
    'Architecture',
    'Hospitality Management',
    'Applied Sciences',
  ];

  final List<String> _locations = [
    'All',
    'Accra, Ghana',
    'Kumasi, Ghana',
    'London, UK',
    'New York, USA',
    'Toronto, Canada',
    'Dubai, UAE',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _filterAnimationController = AnimationController(
      duration: ATUAnimations.medium,
      vsync: this,
    );
    _filteredAlumni = _mockAlumni;
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
                      _buildSearchAndFilters(),
                      if (_showFilters) _buildFilterSection(),
                      _buildStatsRow(),
                      _buildTabBar(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildAllAlumni(),
                            _buildRecentlyActive(),
                            _buildConnections(),
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
      floatingActionButton: _buildNetworkingFAB(),
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
                      'Alumni Directory',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Connect with your fellow graduates',
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
                            '${_mockAlumni.where((a) => a.isRecentlyActive).length} active today',
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
        // QR Code Scanner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            color: ATUColors.primaryGold,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        // Notifications
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: Stack(
            children: [
              const Icon(
                Icons.notifications_rounded,
                color: ATUColors.primaryBlue,
                size: 24,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: ATUColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: ATUColors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: ATUTextStyles.caption.copyWith(
                        color: ATUColors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
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
                          hintText:
                              'Search alumni by name, program, or company...',
                          hintStyle: ATUTextStyles.bodyMedium.copyWith(
                            color: ATUColors.grey400,
                          ),
                          prefixIcon: Icon(
                            _isSearching
                                ? Icons.search_rounded
                                : Icons.search_rounded,
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
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      gradient: _showFilters ? ATUColors.primaryGradient : null,
                      color: _showFilters ? null : ATUColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _showFilters
                            ? Colors.transparent
                            : ATUColors.primaryBlue,
                        width: 2,
                      ),
                      boxShadow: ATUShadows.soft,
                    ),
                    child: IconButton(
                      onPressed: _toggleFilters,
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
              if (_hasActiveFilters()) ...[
                const SizedBox(height: 12),
                _buildActiveFiltersChips(),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildActiveFiltersChips() {
    final activeFilters = <String>[];
    if (_selectedYear != 'All') activeFilters.add('Class of $_selectedYear');
    if (_selectedProgram != 'All') activeFilters.add(_selectedProgram);
    if (_selectedLocation != 'All') activeFilters.add(_selectedLocation);

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...activeFilters.map(
            (filter) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ATUColors.primaryBlue.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ATUColors.primaryBlue.withValues(alpha: .3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filter,
                    style: ATUTextStyles.caption.copyWith(
                      color: ATUColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _removeFilter(filter),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: ATUColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (activeFilters.isNotEmpty)
            GestureDetector(
              onTap: _clearFilters,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ATUColors.error.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Clear All',
                  style: ATUTextStyles.caption.copyWith(
                    color: ATUColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                        'Advanced Filters',
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
                    'Graduation Year',
                    _selectedYear,
                    _graduationYears,
                    Icons.school_rounded,
                    (value) => setState(() => _selectedYear = value!),
                  ),
                  const SizedBox(height: 12),
                  _buildEnhancedFilterDropdown(
                    'Program',
                    _selectedProgram,
                    _programs,
                    Icons.book_rounded,
                    (value) => setState(() => _selectedProgram = value!),
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

  Widget _buildStatsRow() {
    final totalAlumni = _mockAlumni.length;
    final connectedAlumni = _mockAlumni.where((a) => a.isConnected).length;
    final activeAlumni = _mockAlumni.where((a) => a.isRecentlyActive).length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildStatChip(
              'Total Alumni',
              totalAlumni.toString(),
              Icons.people_rounded,
              ATUColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatChip(
              'Connected',
              connectedAlumni.toString(),
              Icons.link_rounded,
              ATUColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatChip(
              'Active Today',
              activeAlumni.toString(),
              Icons.online_prediction_rounded,
              ATUColors.primaryGold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: ATUTextStyles.caption.copyWith(color: color),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
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
              Tab(text: 'All Alumni'),
              Tab(text: 'Recently Active'),
              Tab(text: 'My Network'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildAllAlumni() {
    return _filteredAlumni.isEmpty
        ? _buildEmptyState(
            'No alumni found',
            'Try adjusting your search or filters',
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _filteredAlumni.length,
            itemBuilder: (context, index) {
              return AlumniCard(
                    alumni: _filteredAlumni[index],
                    onTap: () => _showAlumniProfile(_filteredAlumni[index]),
                    onConnect: () => _connectWithAlumni(_filteredAlumni[index]),
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

  Widget _buildRecentlyActive() {
    final recentlyActive = _filteredAlumni
        .where((alumni) => alumni.isRecentlyActive)
        .toList();

    if (recentlyActive.isEmpty) {
      return _buildEmptyState(
        'No Recently Active Alumni',
        'Check back later for updates',
        icon: Icons.timeline_rounded,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: recentlyActive.length,
      itemBuilder: (context, index) {
        return AlumniCard(
          alumni: recentlyActive[index],
          onTap: () => _showAlumniProfile(recentlyActive[index]),
          onConnect: () => _connectWithAlumni(recentlyActive[index]),
          showActivityIndicator: true,
        ).animate().fadeIn(delay: (index * 50).ms, duration: 400.ms);
      },
    );
  }

  Widget _buildConnections() {
    final connections = _filteredAlumni
        .where((alumni) => alumni.isConnected)
        .toList();

    return Column(
      children: [
        // Network Stats Header
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
                  Icons.people_rounded,
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
                      'Your Professional Network',
                      style: ATUTextStyles.h5.copyWith(
                        color: ATUColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${connections.length} connections • Growing strong',
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
                child: Icon(
                  Icons.trending_up_rounded,
                  color: ATUColors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        // Connections List
        Expanded(
          child: connections.isEmpty
              ? _buildEmptyState(
                  'No Connections Yet',
                  'Start connecting with your fellow alumni',
                  icon: Icons.people_outline_rounded,
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: connections.length,
                  itemBuilder: (context, index) {
                    return AlumniCard(
                      alumni: connections[index],
                      onTap: () => _showAlumniProfile(connections[index]),
                      onConnect: () => _messageAlumni(connections[index]),
                      isConnected: true,
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
              icon ?? Icons.search_off_rounded,
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
            onPressed: _refreshData,
            type: ATUButtonType.outline,
            icon: Icons.refresh_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkingFAB() {
    return FloatingActionButton.extended(
      onPressed: _showNetworkingOptions,
      backgroundColor: ATUColors.primaryGold,
      foregroundColor: ATUColors.white,
      elevation: 6,
      icon: const Icon(Icons.group_add_rounded),
      label: Text(
        'Network',
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

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
    if (_showFilters) {
      _filterAnimationController.forward();
    } else {
      _filterAnimationController.reverse();
    }
  }

  bool _hasActiveFilters() {
    return _selectedYear != 'All' ||
        _selectedProgram != 'All' ||
        _selectedLocation != 'All';
  }

  void _removeFilter(String filter) {
    setState(() {
      if (filter.startsWith('Class of')) {
        _selectedYear = 'All';
      } else if (_programs.contains(filter)) {
        _selectedProgram = 'All';
      } else if (_locations.contains(filter)) {
        _selectedLocation = 'All';
      }
      _applyFiltersAndSearch();
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedYear = 'All';
      _selectedProgram = 'All';
      _selectedLocation = 'All';
      _applyFiltersAndSearch();
    });
  }

  void _applyFilters() {
    setState(() {
      _showFilters = false;
      _applyFiltersAndSearch();
    });
    _filterAnimationController.reverse();
  }

  void _applyFiltersAndSearch() {
    setState(() {
      _filteredAlumni = _mockAlumni.where((alumni) {
        // Search filter
        final searchQuery = _searchController.text.toLowerCase();
        final matchesSearch =
            searchQuery.isEmpty ||
            alumni.name.toLowerCase().contains(searchQuery) ||
            alumni.company.toLowerCase().contains(searchQuery) ||
            alumni.program.toLowerCase().contains(searchQuery) ||
            alumni.position.toLowerCase().contains(searchQuery);

        // Other filters
        final matchesYear =
            _selectedYear == 'All' || alumni.graduationYear == _selectedYear;
        final matchesProgram =
            _selectedProgram == 'All' || alumni.program == _selectedProgram;
        final matchesLocation =
            _selectedLocation == 'All' || alumni.location == _selectedLocation;

        return matchesSearch &&
            matchesYear &&
            matchesProgram &&
            matchesLocation;
      }).toList();
    });
  }

  int _getFilteredCount() {
    return _mockAlumni.where((alumni) {
      final matchesYear =
          _selectedYear == 'All' || alumni.graduationYear == _selectedYear;
      final matchesProgram =
          _selectedProgram == 'All' || alumni.program == _selectedProgram;
      final matchesLocation =
          _selectedLocation == 'All' || alumni.location == _selectedLocation;
      return matchesYear && matchesProgram && matchesLocation;
    }).length;
  }

  void _refreshData() {
    setState(() {
      _filteredAlumni = _mockAlumni;
    });
  }

  void _showAlumniProfile(AlumniModel alumni) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAlumniProfileSheet(alumni),
    );
  }

  Widget _buildAlumniProfileSheet(AlumniModel alumni) {
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
                    children: [
                      const SizedBox(height: 24),

                      // Profile header with enhanced design
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Enhanced Avatar with gradient border
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
                                    alumni.name.substring(0, 2).toUpperCase(),
                                    style: ATUTextStyles.h2.copyWith(
                                      color: ATUColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              alumni.name,
                              style: ATUTextStyles.h3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
                                alumni.position,
                                style: ATUTextStyles.bodyMedium.copyWith(
                                  color: ATUColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              alumni.company,
                              style: ATUTextStyles.bodyLarge.copyWith(
                                color: ATUColors.grey600,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),

                            // Connection Status Badge
                            if (alumni.isConnected)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: ATUColors.success.withValues(
                                    alpha: .1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: ATUColors.success.withValues(
                                      alpha: .3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: ATUColors.success,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Connected',
                                      style: ATUTextStyles.bodySmall.copyWith(
                                        color: ATUColors.success,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 20),

                            // Action buttons with enhanced styling
                            Row(
                              children: [
                                Expanded(
                                  child: ATUButton(
                                    text: alumni.isConnected
                                        ? 'Message'
                                        : 'Connect',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (alumni.isConnected) {
                                        _messageAlumni(alumni);
                                      } else {
                                        _connectWithAlumni(alumni);
                                      }
                                    },
                                    type: ATUButtonType.primary,
                                    icon: alumni.isConnected
                                        ? Icons.message_rounded
                                        : Icons.person_add_rounded,
                                    size: ATUButtonSize.small,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ATUButton(
                                  text: '',
                                  onPressed: () => _shareProfile(alumni),
                                  type: ATUButtonType.outline,
                                  icon: Icons.share_rounded,
                                  size: ATUButtonSize.small,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Enhanced Profile details
                      _buildEnhancedProfileSection('Education', [
                        _buildEnhancedProfileItem(
                          Icons.school_rounded,
                          alumni.program,
                          'Class of ${alumni.graduationYear}',
                          ATUColors.primaryBlue,
                        ),
                        _buildEnhancedProfileItem(
                          Icons.location_on_rounded,
                          'Accra Technical University',
                          'Ghana',
                          ATUColors.primaryGold,
                        ),
                      ]),

                      _buildEnhancedProfileSection('Professional', [
                        _buildEnhancedProfileItem(
                          Icons.work_rounded,
                          alumni.position,
                          alumni.company,
                          ATUColors.info,
                        ),
                        _buildEnhancedProfileItem(
                          Icons.place_rounded,
                          alumni.location,
                          'Current Location',
                          ATUColors.success,
                        ),
                      ]),

                      _buildEnhancedProfileSection('Skills & Expertise', [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: alumni.skills
                              .map(
                                (skill) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ATUColors.primaryBlue.withValues(
                                          alpha: .1,
                                        ),
                                        ATUColors.primaryGold.withValues(
                                          alpha: .1,
                                        ),
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
                      ]),

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

  Widget _buildEnhancedProfileSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ATUColors.grey100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: ATUTextStyles.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEnhancedProfileItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ATUColors.grey200),
        boxShadow: ATUShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
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
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: ATUTextStyles.bodySmall.copyWith(
                      color: ATUColors.grey600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _connectWithAlumni(AlumniModel alumni) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Connection request sent to ${alumni.name}')),
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

  void _messageAlumni(AlumniModel alumni) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.message, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Opening chat with ${alumni.name}')),
          ],
        ),
        backgroundColor: ATUColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _shareProfile(AlumniModel alumni) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.share, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Sharing ${alumni.name}\'s profile')),
          ],
        ),
        backgroundColor: ATUColors.primaryGold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showNetworkingOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        decoration: const BoxDecoration(
          color: ATUColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
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
                'Networking Options',
                style: ATUTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildNetworkingOption(
                Icons.qr_code_rounded,
                'Share My QR Code',
                'Let others connect with you',
                ATUColors.primaryBlue,
                () => Navigator.pop(context),
              ),
              _buildNetworkingOption(
                Icons.qr_code_scanner_rounded,
                'Scan QR Code',
                'Connect by scanning',
                ATUColors.primaryGold,
                () => Navigator.pop(context),
              ),
              _buildNetworkingOption(
                Icons.import_contacts_rounded,
                'Import Contacts',
                'Find alumni in your contacts',
                ATUColors.info,
                () => Navigator.pop(context),
              ),
              _buildNetworkingOption(
                Icons.event_rounded,
                'Nearby Events',
                'Network at alumni events',
                ATUColors.success,
                () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkingOption(
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
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: ATUColors.grey400,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: ATUColors.grey50,
      ),
    );
  }
}

// Enhanced Alumni Card Widget
class AlumniCard extends StatelessWidget {
  final AlumniModel alumni;
  final VoidCallback? onTap;
  final VoidCallback? onConnect;
  final bool isConnected;
  final bool showActivityIndicator;

  const AlumniCard({
    super.key,
    required this.alumni,
    this.onTap,
    this.onConnect,
    this.isConnected = false,
    this.showActivityIndicator = false,
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
              color: alumni.isConnected
                  ? ATUColors.success.withValues(alpha: .3)
                  : ATUColors.grey200,
              width: alumni.isConnected ? 2 : 1,
            ),
            boxShadow: ATUShadows.medium,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Enhanced Avatar with status indicators
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient: alumni.isConnected
                              ? ATUColors.primaryGradient
                              : LinearGradient(
                                  colors: [
                                    ATUColors.grey300,
                                    ATUColors.grey400,
                                  ],
                                ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: ATUColors.white,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: ATUColors.primaryBlue,
                            child: Text(
                              alumni.name.substring(0, 2).toUpperCase(),
                              style: ATUTextStyles.bodyLarge.copyWith(
                                color: ATUColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (alumni.isRecentlyActive || showActivityIndicator)
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: ATUColors.success,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ATUColors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  // Alumni info with enhanced styling
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                alumni.name,
                                style: ATUTextStyles.h6.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ATUColors.grey900,
                                ),
                              ),
                            ),
                            if (alumni.isConnected)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      ATUColors.success,
                                      ATUColors.success.withValues(alpha: .7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: ATUColors.white,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Connected',
                                      style: ATUTextStyles.caption.copyWith(
                                        color: ATUColors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ATUColors.primaryBlue.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            alumni.position,
                            style: ATUTextStyles.bodySmall.copyWith(
                              color: ATUColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          alumni.company,
                          style: ATUTextStyles.bodyMedium.copyWith(
                            color: ATUColors.grey700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          Icons.school_rounded,
                          '${alumni.program} • Class of ${alumni.graduationYear}',
                        ),
                        const SizedBox(height: 4),
                        _buildInfoRow(
                          Icons.location_on_rounded,
                          alumni.location,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Enhanced Skills section
              if (alumni.skills.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...alumni.skills.take(3).map((skill) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ATUColors.grey100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: ATUColors.grey300),
                          ),
                          child: Text(
                            skill,
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.grey700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                      if (alumni.skills.length > 3)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: ATUColors.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '+${alumni.skills.length - 3} more',
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Enhanced Action buttons
              Row(
                children: [
                  Expanded(
                    child: ATUButton(
                      text: 'View Profile',
                      onPressed: onTap,
                      type: ATUButtonType.outline,
                      size: ATUButtonSize.small,
                      icon: Icons.person_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ATUButton(
                      text: alumni.isConnected ? 'Message' : 'Connect',
                      onPressed: onConnect,
                      type: ATUButtonType.primary,
                      size: ATUButtonSize.small,
                      icon: alumni.isConnected
                          ? Icons.message_rounded
                          : Icons.person_add_rounded,
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: ATUColors.grey500),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
          ),
        ),
      ],
    );
  }
}

// Mock data model (unchanged)
class AlumniModel {
  final String name;
  final String position;
  final String company;
  final String program;
  final String graduationYear;
  final String location;
  final List<String> skills;
  final bool isConnected;
  final bool isRecentlyActive;

  AlumniModel({
    required this.name,
    required this.position,
    required this.company,
    required this.program,
    required this.graduationYear,
    required this.location,
    required this.skills,
    this.isConnected = false,
    this.isRecentlyActive = false,
  });
}

// Enhanced Mock data with more variety
final List<AlumniModel> _mockAlumni = [
  AlumniModel(
    name: 'Sarah Johnson',
    position: 'Senior Software Engineer',
    company: 'Google',
    program: 'Computer Science',
    graduationYear: '2020',
    location: 'London, UK',
    skills: [
      'Flutter',
      'Python',
      'Machine Learning',
      'Cloud Computing',
      'Team Leadership',
    ],
    isConnected: true,
    isRecentlyActive: true,
  ),
  AlumniModel(
    name: 'Michael Asante',
    position: 'Product Manager',
    company: 'Microsoft',
    program: 'Business Administration',
    graduationYear: '2019',
    location: 'Accra, Ghana',
    skills: ['Product Strategy', 'Agile', 'Data Analysis', 'Market Research'],
    isConnected: false,
    isRecentlyActive: true,
  ),
  AlumniModel(
    name: 'Emma Wilson',
    position: 'Lead UX Designer',
    company: 'Apple',
    program: 'Computer Science',
    graduationYear: '2021',
    location: 'New York, USA',
    skills: [
      'UI/UX Design',
      'Figma',
      'User Research',
      'Design Systems',
      'Prototyping',
    ],
    isConnected: true,
    isRecentlyActive: false,
  ),
  AlumniModel(
    name: 'Kwame Osei',
    position: 'Senior Civil Engineer',
    company: 'Bechtel Corporation',
    program: 'Engineering',
    graduationYear: '2018',
    location: 'Dubai, UAE',
    skills: [
      'Project Management',
      'AutoCAD',
      'Construction',
      'Structural Design',
    ],
    isConnected: false,
    isRecentlyActive: false,
  ),
  AlumniModel(
    name: 'Jennifer Lee',
    position: 'Marketing Director',
    company: 'Coca-Cola',
    program: 'Business Administration',
    graduationYear: '2017',
    location: 'Toronto, Canada',
    skills: [
      'Digital Marketing',
      'Brand Strategy',
      'Analytics',
      'Social Media',
      'Content Strategy',
    ],
    isConnected: true,
    isRecentlyActive: true,
  ),
  AlumniModel(
    name: 'David Mensah',
    position: 'Software Architect',
    company: 'Amazon',
    program: 'Computer Science',
    graduationYear: '2016',
    location: 'Accra, Ghana',
    skills: ['System Architecture', 'AWS', 'Java', 'Microservices', 'DevOps'],
    isConnected: false,
    isRecentlyActive: true,
  ),
  AlumniModel(
    name: 'Grace Owusu',
    position: 'Financial Analyst',
    company: 'Goldman Sachs',
    program: 'Business Administration',
    graduationYear: '2022',
    location: 'New York, USA',
    skills: [
      'Financial Modeling',
      'Risk Analysis',
      'Excel',
      'Python',
      'Bloomberg Terminal',
    ],
    isConnected: true,
    isRecentlyActive: false,
  ),
  AlumniModel(
    name: 'Robert Asiedu',
    position: 'Mechanical Engineer',
    company: 'Tesla',
    program: 'Engineering',
    graduationYear: '2020',
    location: 'Kumasi, Ghana',
    skills: [
      'CAD Design',
      'Manufacturing',
      'Quality Control',
      'Lean Manufacturing',
    ],
    isConnected: false,
    isRecentlyActive: false,
  ),
];
