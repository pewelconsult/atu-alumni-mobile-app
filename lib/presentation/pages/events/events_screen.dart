// lib/presentation/pages/events/events_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/common/atu_text_field.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _filterAnimationController;

  String _selectedCategory = 'All';
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Networking',
    'Career Development',
    'Social',
    'Academic',
    'Alumni Meetup',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _filterAnimationController = AnimationController(
      duration: ATUAnimations.medium,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _filterAnimationController.dispose();
    _searchController.dispose();
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
                      _buildCategoryFilter(),
                      _buildTabBar(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildUpcomingEvents(),
                            _buildMyEvents(),
                            _buildPastEvents(),
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
      floatingActionButton: _buildCreateEventFAB(),
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
                      'Events & Activities',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stay connected with alumni activities',
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
                              color: ATUColors.primaryGold,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_mockUpcomingEvents.length} upcoming events',
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
        // Calendar view
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: ATUShadows.medium,
          ),
          child: const Icon(
            Icons.calendar_month_rounded,
            color: ATUColors.primaryGold,
            size: 24,
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
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search events by title, location, or category...',
                hintStyle: ATUTextStyles.bodyMedium.copyWith(
                  color: ATUColors.grey400,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: ATUColors.primaryBlue,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
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
    final totalEvents = _mockUpcomingEvents.length + _mockPastEvents.length;
    final registeredEvents = _mockUpcomingEvents
        .where((e) => e.isRSVPed)
        .length;
    final thisMonth = _mockUpcomingEvents.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Events',
              totalEvents.toString(),
              Icons.event_rounded,
              ATUColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Registered',
              registeredEvents.toString(),
              Icons.event_available_rounded,
              ATUColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'This Month',
              thisMonth.toString(),
              Icons.today_rounded,
              ATUColors.primaryGold,
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

  Widget _buildCategoryFilter() {
    return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = category == _selectedCategory;

              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  backgroundColor: ATUColors.white,
                  selectedColor: ATUColors.primaryBlue.withValues(alpha: .1),
                  labelStyle: ATUTextStyles.bodySmall.copyWith(
                    color: isSelected
                        ? ATUColors.primaryBlue
                        : ATUColors.grey600,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  side: BorderSide(
                    color: isSelected
                        ? ATUColors.primaryBlue
                        : ATUColors.grey300,
                    width: isSelected ? 2 : 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: isSelected ? 2 : 0,
                  shadowColor: ATUColors.primaryBlue.withValues(alpha: .3),
                ),
              );
            },
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
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
              Tab(text: 'Upcoming'),
              Tab(text: 'My Events'),
              Tab(text: 'Past Events'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildUpcomingEvents() {
    List<EventModel> filteredEvents = _mockUpcomingEvents;

    // Apply category filter
    if (_selectedCategory != 'All') {
      filteredEvents = filteredEvents
          .where((event) => event.category == _selectedCategory)
          .toList();
    }

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final searchQuery = _searchController.text.toLowerCase();
      filteredEvents = filteredEvents.where((event) {
        return event.title.toLowerCase().contains(searchQuery) ||
            event.location.toLowerCase().contains(searchQuery) ||
            event.category.toLowerCase().contains(searchQuery);
      }).toList();
    }

    if (filteredEvents.isEmpty) {
      return _buildEmptyState(
        'No upcoming events found',
        'Try adjusting your search or category filter',
        Icons.event_busy_rounded,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        return EnhancedEventCard(
              event: filteredEvents[index],
              onTap: () => _showEventDetails(filteredEvents[index]),
              onRSVP: () => _rsvpToEvent(filteredEvents[index]),
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

  Widget _buildMyEvents() {
    final myEvents = _mockUpcomingEvents
        .where((event) => event.isRSVPed)
        .toList();

    return Column(
      children: [
        // Enhanced Network Stats Header
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
                  Icons.event_available_rounded,
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
                      'My Events',
                      style: ATUTextStyles.h5.copyWith(
                        color: ATUColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${myEvents.length} events registered • Stay engaged',
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
                child: GestureDetector(
                  onTap: _addToCalendar,
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    color: ATUColors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Events List
        Expanded(
          child: myEvents.isEmpty
              ? _buildEmptyState(
                  'No registered events',
                  'Start RSVPing to events to see them here',
                  Icons.event_available_outlined,
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: myEvents.length,
                  itemBuilder: (context, index) {
                    return EnhancedEventCard(
                      event: myEvents[index],
                      onTap: () => _showEventDetails(myEvents[index]),
                      onRSVP: () => _manageRSVP(myEvents[index]),
                      showRSVPStatus: true,
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

  Widget _buildPastEvents() {
    return _mockPastEvents.isEmpty
        ? _buildEmptyState(
            'No past events',
            'Past events will appear here',
            Icons.history_rounded,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _mockPastEvents.length,
            itemBuilder: (context, index) {
              return EnhancedEventCard(
                event: _mockPastEvents[index],
                onTap: () => _showEventDetails(_mockPastEvents[index]),
                isPastEvent: true,
              ).animate().fadeIn(delay: (index * 50).ms, duration: 400.ms);
            },
          );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
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
            child: Icon(icon, size: 48, color: ATUColors.grey400),
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

  Widget _buildCreateEventFAB() {
    return FloatingActionButton.extended(
      onPressed: _createEvent,
      backgroundColor: ATUColors.primaryGold,
      foregroundColor: ATUColors.white,
      elevation: 6,
      icon: const Icon(Icons.add_rounded),
      label: Text(
        'Create Event',
        style: ATUTextStyles.buttonTextSmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    ).animate().scale(delay: 800.ms);
  }

  void _showEventDetails(EventModel event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEventDetailsSheet(event),
    );
  }

  Widget _buildEventDetailsSheet(EventModel event) {
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

                      // Event header with enhanced design
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              event.categoryColor.withValues(alpha: .1),
                              event.categoryColor.withValues(alpha: .05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: event.categoryColor.withValues(alpha: .3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: event.categoryColor.withValues(
                                      alpha: .2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    event.category,
                                    style: ATUTextStyles.caption.copyWith(
                                      color: event.categoryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (event.isRSVPed)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
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
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Registered',
                                          style: ATUTextStyles.caption.copyWith(
                                            color: ATUColors.success,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              event.title,
                              style: ATUTextStyles.h3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildEnhancedEventDetailItem(
                              Icons.calendar_today_rounded,
                              'Date',
                              event.date,
                              ATUColors.primaryBlue,
                            ),
                            _buildEnhancedEventDetailItem(
                              Icons.access_time_rounded,
                              'Time',
                              event.time,
                              ATUColors.primaryGold,
                            ),
                            _buildEnhancedEventDetailItem(
                              Icons.location_on_rounded,
                              'Location',
                              event.location,
                              ATUColors.info,
                            ),
                            _buildEnhancedEventDetailItem(
                              Icons.people_rounded,
                              'Attendees',
                              '${event.attendeesCount} registered',
                              ATUColors.success,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Description section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ATUColors.grey50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ATUColors.grey200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.description_rounded,
                                  color: ATUColors.primaryBlue,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Event Description',
                                  style: ATUTextStyles.h6.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ATUColors.grey900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              event.description,
                              style: ATUTextStyles.bodyMedium.copyWith(
                                color: ATUColors.grey600,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action buttons
                      if (!event.isPastEvent)
                        Row(
                          children: [
                            Expanded(
                              child: ATUButton(
                                text: event.isRSVPed
                                    ? 'Cancel RSVP'
                                    : 'RSVP Now',
                                onPressed: () {
                                  Navigator.pop(context);
                                  if (event.isRSVPed) {
                                    _cancelRSVP(event);
                                  } else {
                                    _rsvpToEvent(event);
                                  }
                                },
                                type: event.isRSVPed
                                    ? ATUButtonType.outline
                                    : ATUButtonType.primary,
                                icon: event.isRSVPed
                                    ? Icons.cancel_rounded
                                    : Icons.event_available_rounded,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ATUButton(
                              text: '',
                              onPressed: () => _shareEvent(event),
                              type: ATUButtonType.outline,
                              icon: Icons.share_rounded,
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: ATUButton(
                                text: 'View Event Photos',
                                onPressed: () => _viewEventPhotos(event),
                                type: ATUButtonType.outline,
                                icon: Icons.photo_library_rounded,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ATUButton(
                              text: '',
                              onPressed: () => _shareEvent(event),
                              type: ATUButtonType.outline,
                              icon: Icons.share_rounded,
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

  Widget _buildEnhancedEventDetailItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: ATUTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: ATUTextStyles.bodySmall.copyWith(color: ATUColors.grey600),
            ),
          ),
        ],
      ),
    );
  }

  void _createEvent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCreateEventSheet(),
    );
  }

  Widget _buildCreateEventSheet() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final locationController = TextEditingController();
    String selectedEventCategory = 'Networking';
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

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
                            Icons.add_rounded,
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
                                'Create New Event',
                                style: ATUTextStyles.h4.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Organize an alumni gathering',
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
                          // Event Title
                          _buildFormSection(
                            'Event Title',
                            ATUTextField(
                              controller: titleController,
                              label: '',
                              hint: 'Enter event title',
                            ),
                          ),

                          // Category Selection
                          _buildFormSection(
                            'Category',
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: ATUColors.grey50,
                                border: Border.all(color: ATUColors.grey300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedEventCategory,
                                  onChanged: (value) {
                                    setModalState(() {
                                      selectedEventCategory = value!;
                                    });
                                  },
                                  isExpanded: true,
                                  items: _categories
                                      .where((cat) => cat != 'All')
                                      .map((category) {
                                        return DropdownMenuItem<String>(
                                          value: category,
                                          child: Text(
                                            category,
                                            style: ATUTextStyles.bodyMedium,
                                          ),
                                        );
                                      })
                                      .toList(),
                                ),
                              ),
                            ),
                          ),

                          // Date and Time
                          Row(
                            children: [
                              Expanded(
                                child: _buildFormSection(
                                  'Date',
                                  GestureDetector(
                                    onTap: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          const Duration(days: 365),
                                        ),
                                      );
                                      if (date != null) {
                                        setModalState(() {
                                          selectedDate = date;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: ATUColors.grey50,
                                        border: Border.all(
                                          color: ATUColors.grey300,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today_rounded,
                                            color: ATUColors.primaryBlue,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            selectedDate != null
                                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                                : 'Select date',
                                            style: ATUTextStyles.bodyMedium
                                                .copyWith(
                                                  color: selectedDate != null
                                                      ? ATUColors.grey900
                                                      : ATUColors.grey400,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildFormSection(
                                  'Time',
                                  GestureDetector(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        setModalState(() {
                                          selectedTime = time;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: ATUColors.grey50,
                                        border: Border.all(
                                          color: ATUColors.grey300,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: ATUColors.primaryGold,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            selectedTime != null
                                                ? selectedTime!.format(context)
                                                : 'Select time',
                                            style: ATUTextStyles.bodyMedium
                                                .copyWith(
                                                  color: selectedTime != null
                                                      ? ATUColors.grey900
                                                      : ATUColors.grey400,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Location
                          _buildFormSection(
                            'Location',
                            ATUTextField(
                              controller: locationController,
                              label: '',
                              hint: 'Enter event location',
                              prefixIcon: Icons.location_on_rounded,
                            ),
                          ),

                          // Description
                          _buildFormSection(
                            'Description',
                            ATUTextField(
                              controller: descriptionController,
                              label: '',
                              hint: 'Describe your event...',
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
                                  text: 'Create Event',
                                  onPressed: () {
                                    _submitCreateEvent(
                                      titleController.text,
                                      descriptionController.text,
                                      locationController.text,
                                      selectedEventCategory,
                                      selectedDate,
                                      selectedTime,
                                    );
                                    Navigator.pop(context);
                                  },
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
      },
    );
  }

  Widget _buildFormSection(String title, Widget child) {
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

  void _submitCreateEvent(
    String title,
    String description,
    String location,
    String category,
    DateTime? date,
    TimeOfDay? time,
  ) {
    if (title.isEmpty ||
        description.isEmpty ||
        location.isEmpty ||
        date == null ||
        time == null) {
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
            Expanded(child: Text('Event "$title" created successfully!')),
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

  void _rsvpToEvent(EventModel event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('RSVP confirmed for ${event.title}')),
          ],
        ),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _cancelRSVP(EventModel event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.cancel, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('RSVP cancelled for ${event.title}')),
          ],
        ),
        backgroundColor: ATUColors.warning,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _manageRSVP(EventModel event) {
    _cancelRSVP(event);
  }

  void _shareEvent(EventModel event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.share, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Sharing ${event.title}')),
          ],
        ),
        backgroundColor: ATUColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _viewEventPhotos(EventModel event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.photo_library, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Opening photo gallery for ${event.title}')),
          ],
        ),
        backgroundColor: ATUColors.primaryGold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _addToCalendar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.calendar_today, color: ATUColors.white),
            SizedBox(width: 12),
            Text('Events added to calendar'),
          ],
        ),
        backgroundColor: ATUColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Enhanced Event Card Widget
class EnhancedEventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;
  final VoidCallback? onRSVP;
  final bool showRSVPStatus;
  final bool isPastEvent;

  const EnhancedEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onRSVP,
    this.showRSVPStatus = false,
    this.isPastEvent = false,
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
              color: event.isRSVPed
                  ? ATUColors.success.withValues(alpha: .3)
                  : event.categoryColor.withValues(alpha: .2),
              width: event.isRSVPed ? 2 : 1,
            ),
            boxShadow: ATUShadows.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Header with category and status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          event.categoryColor,
                          event.categoryColor.withValues(alpha: .7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      event.category,
                      style: ATUTextStyles.caption.copyWith(
                        color: ATUColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (showRSVPStatus && event.isRSVPed)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ATUColors.success,
                            ATUColors.success.withValues(alpha: .7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 14,
                            color: ATUColors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Registered',
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isPastEvent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ATUColors.grey300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Completed',
                        style: ATUTextStyles.caption.copyWith(
                          color: ATUColors.grey700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Event title with enhanced styling
              Text(
                event.title,
                style: ATUTextStyles.h6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),

              const SizedBox(height: 12),

              // Enhanced Event details with icons
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.grey50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ATUColors.grey200),
                ),
                child: Column(
                  children: [
                    _buildEnhancedEventDetail(
                      Icons.calendar_today_rounded,
                      event.date,
                      ATUColors.primaryBlue,
                    ),
                    const SizedBox(height: 6),
                    _buildEnhancedEventDetail(
                      Icons.access_time_rounded,
                      event.time,
                      ATUColors.primaryGold,
                    ),
                    const SizedBox(height: 6),
                    _buildEnhancedEventDetail(
                      Icons.location_on_rounded,
                      event.location,
                      ATUColors.info,
                    ),
                    const SizedBox(height: 6),
                    _buildEnhancedEventDetail(
                      Icons.people_rounded,
                      '${event.attendeesCount} attendees',
                      ATUColors.success,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Event description with better styling
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ATUColors.grey200),
                ),
                child: Text(
                  event.description,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.grey600,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 20),

              // Enhanced Action buttons
              if (!isPastEvent)
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
                        text: event.isRSVPed ? 'Manage' : 'RSVP',
                        onPressed: onRSVP,
                        type: event.isRSVPed
                            ? ATUButtonType.secondary
                            : ATUButtonType.primary,
                        size: ATUButtonSize.small,
                        icon: event.isRSVPed
                            ? Icons.edit_calendar_rounded
                            : Icons.event_available_rounded,
                      ),
                    ),
                  ],
                )
              else
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
                        text: 'Photos',
                        onPressed: () {},
                        type: ATUButtonType.text,
                        size: ATUButtonSize.small,
                        icon: Icons.photo_library_rounded,
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

  Widget _buildEnhancedEventDetail(IconData icon, String text, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: ATUTextStyles.bodySmall.copyWith(
              color: ATUColors.grey600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// Event model (unchanged)
class EventModel {
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String category;
  final Color categoryColor;
  final int attendeesCount;
  final bool isRSVPed;
  final bool isPastEvent;

  EventModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.categoryColor,
    required this.attendeesCount,
    this.isRSVPed = false,
    this.isPastEvent = false,
  });
}

// Enhanced Mock data with more events
final List<EventModel> _mockUpcomingEvents = [
  EventModel(
    title: 'Alumni Networking Night',
    description:
        'Join fellow ATU alumni for an evening of networking, professional development, and reconnecting with old friends. Light refreshments will be provided.',
    date: 'December 15, 2024',
    time: '6:00 PM - 9:00 PM',
    location: 'ATU Main Campus, Conference Hall',
    category: 'Networking',
    categoryColor: ATUColors.primaryBlue,
    attendeesCount: 45,
    isRSVPed: true,
  ),
  EventModel(
    title: 'Career Development Workshop',
    description:
        'Learn about the latest industry trends, interview techniques, and career advancement strategies from industry experts.',
    date: 'December 20, 2024',
    time: '2:00 PM - 5:00 PM',
    location: 'Online Event',
    category: 'Career Development',
    categoryColor: ATUColors.success,
    attendeesCount: 120,
    isRSVPed: false,
  ),
  EventModel(
    title: 'Tech Innovation Summit 2025',
    description:
        'Annual technology meetup featuring presentations on AI, blockchain, and emerging technologies by ATU alumni working in tech.',
    date: 'January 5, 2025',
    time: '10:00 AM - 4:00 PM',
    location: 'Accra Tech Hub',
    category: 'Academic',
    categoryColor: ATUColors.info,
    attendeesCount: 80,
    isRSVPed: true,
  ),
  EventModel(
    title: 'Alumni Christmas Social',
    description:
        'Celebrate the holiday season with your fellow alumni in a festive atmosphere with music, food, and great company.',
    date: 'December 22, 2024',
    time: '7:00 PM - 11:00 PM',
    location: 'Labadi Beach Hotel',
    category: 'Social',
    categoryColor: ATUColors.primaryGold,
    attendeesCount: 65,
    isRSVPed: false,
  ),
  EventModel(
    title: 'Business Leadership Forum',
    description:
        'Leadership insights and business strategies shared by successful alumni entrepreneurs and executives.',
    date: 'January 12, 2025',
    time: '9:00 AM - 12:00 PM',
    location: 'ATU Business School',
    category: 'Career Development',
    categoryColor: ATUColors.success,
    attendeesCount: 90,
    isRSVPed: false,
  ),
  EventModel(
    title: 'Regional Alumni Meetup - Kumasi',
    description:
        'Connect with fellow alumni in the Ashanti region for networking and professional development.',
    date: 'January 18, 2025',
    time: '5:00 PM - 8:00 PM',
    location: 'Golden Tulip Hotel, Kumasi',
    category: 'Alumni Meetup',
    categoryColor: ATUColors.primaryGold,
    attendeesCount: 35,
    isRSVPed: true,
  ),
];

final List<EventModel> _mockPastEvents = [
  EventModel(
    title: 'ATU Alumni Annual Gala',
    description:
        'Our annual celebration of achievements and milestones of our alumni community.',
    date: 'November 10, 2024',
    time: '6:00 PM - 11:00 PM',
    location: 'Kempinski Hotel Gold Coast City',
    category: 'Alumni Meetup',
    categoryColor: ATUColors.primaryGold,
    attendeesCount: 200,
    isPastEvent: true,
  ),
  EventModel(
    title: 'Entrepreneurship Summit 2024',
    description:
        'A day-long event featuring successful alumni entrepreneurs sharing their journey and insights.',
    date: 'October 25, 2024',
    time: '9:00 AM - 5:00 PM',
    location: 'ATU Business School',
    category: 'Career Development',
    categoryColor: ATUColors.success,
    attendeesCount: 150,
    isPastEvent: true,
  ),
  EventModel(
    title: 'Alumni Sports Day',
    description:
        'Annual sports tournament bringing together alumni for friendly competition and camaraderie.',
    date: 'September 15, 2024',
    time: '8:00 AM - 6:00 PM',
    location: 'ATU Sports Complex',
    category: 'Social',
    categoryColor: ATUColors.primaryGold,
    attendeesCount: 120,
    isPastEvent: true,
  ),
];
