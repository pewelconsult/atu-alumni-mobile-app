// lib/presentation/pages/surveys/surveys_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/cards/survey_card.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({super.key});

  @override
  State<SurveysScreen> createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAvailableSurveys(),
                    _buildCompletedSurveys(),
                    _buildMyResponses(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                      'Career Surveys',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    Text(
                      'Help us track your career journey',
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
                  Icons.poll_rounded,
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
              Tab(text: 'Available'),
              Tab(text: 'Completed'),
              Tab(text: 'My Responses'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildAvailableSurveys() {
    return Column(
      children: [
        // Incentive banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: ATUColors.goldGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.stars_rounded, color: ATUColors.white, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete surveys, help ATU!',
                      style: ATUTextStyles.bodyLarge.copyWith(
                        color: ATUColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your responses help improve education quality',
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

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _mockAvailableSurveys.length,
            itemBuilder: (context, index) {
              return SurveyCard(
                    survey: _mockAvailableSurveys[index],
                    onTap: () => _takeSurvey(_mockAvailableSurveys[index]),
                    isAvailable: true,
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
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedSurveys() {
    final completedSurveys = _mockAvailableSurveys
        .where((s) => s.isCompleted)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: completedSurveys.length,
      itemBuilder: (context, index) {
        return SurveyCard(
          survey: completedSurveys[index],
          onTap: () => _viewSurveyResults(completedSurveys[index]),
          isAvailable: false,
        );
      },
    );
  }

  Widget _buildMyResponses() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Your Survey History',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 16),

          // Response statistics
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResponseStat('Completed', '3', ATUColors.success),
                    _buildResponseStat('Pending', '2', ATUColors.warning),
                    _buildResponseStat('Total', '5', ATUColors.primaryBlue),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Thank you for participating in our surveys! Your responses help us improve ATU\'s programs.',
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recent responses
          Text(
            'Recent Responses',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey800,
            ),
          ),
          const SizedBox(height: 12),

          ..._mockMyResponses.map((response) => _buildResponseItem(response)),
        ],
      ),
    );
  }

  Widget _buildResponseStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: ATUTextStyles.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: ATUTextStyles.bodySmall.copyWith(color: ATUColors.grey600),
        ),
      ],
    );
  }

  Widget _buildResponseItem(SurveyResponseModel response) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ATUColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getStatusColor(response.status).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getStatusIcon(response.status),
              color: _getStatusColor(response.status),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  response.surveyTitle,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ATUColors.grey900,
                  ),
                ),
                Text(
                  'Completed on ${response.completedDate}',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(response.status).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              response.status,
              style: ATUTextStyles.caption.copyWith(
                color: _getStatusColor(response.status),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return ATUColors.success;
      case 'Pending':
        return ATUColors.warning;
      default:
        return ATUColors.grey500;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle_rounded;
      case 'Pending':
        return Icons.schedule_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  void _takeSurvey(DetailedSurveyModel survey) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SurveyFormScreen(survey: survey)),
    );
  }

  void _viewSurveyResults(DetailedSurveyModel survey) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing results for ${survey.title}'),
        backgroundColor: ATUColors.info,
      ),
    );
  }
}

// lib/presentation/pages/surveys/survey_form_screen.dart
class SurveyFormScreen extends StatefulWidget {
  final DetailedSurveyModel survey;

  const SurveyFormScreen({super.key, required this.survey});

  @override
  State<SurveyFormScreen> createState() => _SurveyFormScreenState();
}

class _SurveyFormScreenState extends State<SurveyFormScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Map<String, dynamic> _responses = {};
  bool _isSubmitting = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
        backgroundColor: ATUColors.primaryBlue,
        foregroundColor: ATUColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentPage + 1} of ${widget.survey.questions.length}',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ATUColors.grey700,
                      ),
                    ),
                    Text(
                      '${((_currentPage + 1) / widget.survey.questions.length * 100).round()}%',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ATUColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentPage + 1) / widget.survey.questions.length,
                  backgroundColor: ATUColors.grey200,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    ATUColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),

          // Survey questions
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: widget.survey.questions.length,
              itemBuilder: (context, index) {
                return _buildQuestionPage(widget.survey.questions[index]);
              },
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: ATUButton(
                      text: 'Previous',
                      onPressed: _previousQuestion,
                      type: ATUButtonType.outline,
                    ),
                  ),
                if (_currentPage > 0) const SizedBox(width: 16),
                Expanded(
                  child: ATUButton(
                    text: _currentPage == widget.survey.questions.length - 1
                        ? 'Submit Survey'
                        : 'Next',
                    onPressed:
                        _currentPage == widget.survey.questions.length - 1
                        ? _submitSurvey
                        : _nextQuestion,
                    type: ATUButtonType.primary,
                    isLoading: _isSubmitting,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(SurveyQuestionModel question) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          if (question.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              question.description,
              style: ATUTextStyles.bodyMedium.copyWith(
                color: ATUColors.grey600,
              ),
            ),
          ],
          const SizedBox(height: 24),
          _buildQuestionInput(question),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(SurveyQuestionModel question) {
    switch (question.type) {
      case 'text':
        return _buildTextInput(question);
      case 'multipleChoice':
        return _buildMultipleChoice(question);
      case 'dropdown':
        return _buildDropdown(question);
      case 'rating':
        return _buildRating(question);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTextInput(SurveyQuestionModel question) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your response...',
        filled: true,
        fillColor: ATUColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.primaryBlue, width: 2),
        ),
      ),
      maxLines: question.id == 'feedback' ? 4 : 1,
      onChanged: (value) {
        _responses[question.id] = value;
      },
    );
  }

  Widget _buildMultipleChoice(SurveyQuestionModel question) {
    return Column(
      children: question.options.map((option) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _responses[question.id],
            onChanged: (value) {
              setState(() {
                _responses[question.id] = value;
              });
            },
            activeColor: ATUColors.primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: ATUColors.grey50,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdown(SurveyQuestionModel question) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: ATUColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.primaryBlue, width: 2),
        ),
      ),
      hint: const Text('Select an option'),
      value: _responses[question.id],
      items: question.options.map((option) {
        return DropdownMenuItem<String>(value: option, child: Text(option));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _responses[question.id] = value;
        });
      },
    );
  }

  Widget _buildRating(SurveyQuestionModel question) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final rating = index + 1;
        final isSelected = _responses[question.id] == rating;

        return GestureDetector(
          onTap: () {
            setState(() {
              _responses[question.id] = rating;
            });
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? ATUColors.primaryBlue : ATUColors.grey100,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected ? ATUColors.primaryBlue : ATUColors.grey300,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                rating.toString(),
                style: ATUTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? ATUColors.white : ATUColors.grey600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _nextQuestion() {
    if (_currentPage < widget.survey.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousQuestion() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitSurvey() async {
    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ATUColors.success.withValues(alpha: .1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: ATUColors.success,
                ),
              ),
              const SizedBox(width: 12),
              const Text('Survey Submitted!'),
            ],
          ),
          content: Text(
            'Thank you for participating in our survey. Your responses help us improve ATU\'s programs.',
            style: ATUTextStyles.bodyMedium,
          ),
          actions: [
            ATUButton(
              text: 'Done',
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close survey screen
              },
              type: ATUButtonType.primary,
            ),
          ],
        ),
      );
    }
  }
}

// Survey Models
class DetailedSurveyModel {
  final String id;
  final String title;
  final String description;
  final int estimatedMinutes;
  final String category;
  final List<SurveyQuestionModel> questions;
  final bool isCompleted;
  final String deadline;

  DetailedSurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedMinutes,
    required this.category,
    required this.questions,
    this.isCompleted = false,
    required this.deadline,
  });
}

class SurveyQuestionModel {
  final String id;
  final String question;
  final String description;
  final String type; // text, multipleChoice, dropdown, rating
  final List<String> options;
  final bool isRequired;

  SurveyQuestionModel({
    required this.id,
    required this.question,
    this.description = '',
    required this.type,
    this.options = const [],
    this.isRequired = true,
  });
}

class SurveyResponseModel {
  final String surveyId;
  final String surveyTitle;
  final String status;
  final String completedDate;

  SurveyResponseModel({
    required this.surveyId,
    required this.surveyTitle,
    required this.status,
    required this.completedDate,
  });
}

// Mock data
final List<DetailedSurveyModel> _mockAvailableSurveys = [
  DetailedSurveyModel(
    id: '1',
    title: 'Employment Status Survey 2024',
    description:
        'Help us understand your current employment situation and career progression.',
    estimatedMinutes: 8,
    category: 'Employment',
    deadline: 'Dec 31, 2024',
    questions: [
      SurveyQuestionModel(
        id: 'employment_status',
        question: 'What is your current employment status?',
        type: 'multipleChoice',
        options: [
          'Employed full-time',
          'Employed part-time',
          'Self-employed',
          'Unemployed - seeking work',
          'Unemployed - not seeking work',
          'Continuing education',
        ],
      ),
      SurveyQuestionModel(
        id: 'salary_range',
        question: 'What is your current monthly salary range?',
        type: 'dropdown',
        options: [
          'Below ₵2,000',
          '₵2,000 - ₵4,999',
          '₵5,000 - ₵9,999',
          '₵10,000 - ₵19,999',
          '₵20,000 and above',
          'Prefer not to say',
        ],
      ),
      SurveyQuestionModel(
        id: 'job_satisfaction',
        question: 'How satisfied are you with your current job?',
        description: 'Rate from 1 (Very Dissatisfied) to 5 (Very Satisfied)',
        type: 'rating',
      ),
      SurveyQuestionModel(
        id: 'feedback',
        question: 'Any additional comments about your career journey?',
        type: 'text',
        isRequired: false,
      ),
    ],
  ),
  DetailedSurveyModel(
    id: '2',
    title: 'Skills & Training Needs Assessment',
    description:
        'Help us identify skill gaps and training opportunities for our alumni.',
    estimatedMinutes: 12,
    category: 'Skills Development',
    deadline: 'Jan 15, 2025',
    questions: [
      SurveyQuestionModel(
        id: 'skills_lacking',
        question: 'Which skills do you feel you lacked when you graduated?',
        type: 'multipleChoice',
        options: [
          'Technical/Software skills',
          'Communication skills',
          'Leadership skills',
          'Project management',
          'Financial literacy',
          'Entrepreneurship',
        ],
      ),
      SurveyQuestionModel(
        id: 'training_interest',
        question: 'What type of training would you be most interested in?',
        type: 'dropdown',
        options: [
          'Online courses',
          'Weekend workshops',
          'Evening classes',
          'Intensive bootcamps',
          'Mentorship programs',
        ],
      ),
    ],
  ),
];

final List<SurveyResponseModel> _mockMyResponses = [
  SurveyResponseModel(
    surveyId: '1',
    surveyTitle: 'Graduate Outcome Survey 2023',
    status: 'Completed',
    completedDate: 'Nov 15, 2024',
  ),
  SurveyResponseModel(
    surveyId: '2',
    surveyTitle: 'Alumni Satisfaction Survey',
    status: 'Completed',
    completedDate: 'Oct 22, 2024',
  ),
  SurveyResponseModel(
    surveyId: '3',
    surveyTitle: 'Career Development Survey',
    status: 'Pending',
    completedDate: 'In Progress',
  ),
];
