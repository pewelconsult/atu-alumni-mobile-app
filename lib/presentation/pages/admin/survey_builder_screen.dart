// lib/presentation/pages/admin/survey_builder_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/survey_model.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/common/atu_text_field.dart';

class SurveyBuilderScreen extends StatefulWidget {
  final SurveyModel? existingSurvey;

  const SurveyBuilderScreen({super.key, this.existingSurvey});

  @override
  State<SurveyBuilderScreen> createState() => _SurveyBuilderScreenState();
}

class _SurveyBuilderScreenState extends State<SurveyBuilderScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late TabController _tabController;

  SurveyType _selectedType = SurveyType.employmentStatus;
  List<SurveyQuestion> _questions = [];
  SurveyTargeting _targeting = SurveyTargeting();
  SurveySettings _settings = SurveySettings();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    if (widget.existingSurvey != null) {
      _loadExistingSurvey();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _loadExistingSurvey() {
    final survey = widget.existingSurvey!;
    _titleController.text = survey.title;
    _descriptionController.text = survey.description;
    _selectedType = survey.type;
    _questions = List.from(survey.questions);
    _targeting = survey.targeting;
    _settings = survey.settings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingSurvey != null ? 'Edit Survey' : 'Create Survey',
        ),
        backgroundColor: ATUColors.primaryBlue,
        foregroundColor: ATUColors.white,
        elevation: 0,
        actions: [
          // Save Draft Button with Loading State
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ATUColors.white,
                      ),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _saveDraft,
                  child: Text(
                    'Save Draft',
                    style: ATUTextStyles.bodyMedium.copyWith(
                      color: ATUColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

          // Publish Button with Loading State
          _isLoading
              ? const SizedBox(width: 16)
              : TextButton(
                  onPressed: _publishSurvey,
                  child: Text(
                    'Publish',
                    style: ATUTextStyles.bodyMedium.copyWith(
                      color: ATUColors.primaryGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: Column(
          children: [
            // Tab bar
            Container(
              color: ATUColors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: ATUColors.primaryBlue,
                unselectedLabelColor: ATUColors.grey600,
                indicatorColor: ATUColors.primaryBlue,
                labelStyle: ATUTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Basic Info'),
                  Tab(text: 'Questions'),
                  Tab(text: 'Targeting'),
                  Tab(text: 'Settings'),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: AbsorbPointer(
                absorbing: _isLoading,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBasicInfoTab(),
                    _buildQuestionsTab(),
                    _buildTargetingTab(),
                    _buildSettingsTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Survey Information',
              style: ATUTextStyles.h4.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
            const SizedBox(height: 24),

            ATUTextField(
              label: 'Survey Title',
              hint: 'Enter a descriptive title for your survey',
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a survey title';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            ATUTextField(
              label: 'Description',
              hint: 'Describe the purpose and scope of this survey',
              controller: _descriptionController,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            Text(
              'Survey Type',
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
                child: DropdownButton<SurveyType>(
                  value: _selectedType,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                  items: SurveyType.values.map((type) {
                    return DropdownMenuItem<SurveyType>(
                      value: type,
                      child: Text(_getSurveyTypeLabel(type)),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Survey type description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ATUColors.info.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ATUColors.info.withValues(alpha: .3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: ATUColors.info,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Survey Type Information',
                        style: ATUTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ATUColors.info,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getSurveyTypeDescription(_selectedType),
                    style: ATUTextStyles.bodySmall.copyWith(
                      color: ATUColors.grey700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildQuestionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Survey Questions',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              ATUButton(
                text: 'Add Question',
                onPressed: _showAddQuestionDialog,
                type: ATUButtonType.primary,
                size: ATUButtonSize.small,
                icon: Icons.add_rounded,
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (_questions.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: ATUColors.grey50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ATUColors.grey200),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.quiz_outlined,
                      size: 48,
                      color: ATUColors.grey400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Questions Added',
                      style: ATUTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ATUColors.grey600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start building your survey by adding questions',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...List.generate(_questions.length, (index) {
              return _buildQuestionCard(_questions[index], index);
            }),

          const SizedBox(height: 32),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildQuestionCard(SurveyQuestion question, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getQuestionTypeColor(
                    question.type,
                  ).withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getQuestionTypeLabel(question.type),
                  style: ATUTextStyles.caption.copyWith(
                    color: _getQuestionTypeColor(question.type),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _editQuestion(index),
                icon: const Icon(Icons.edit_rounded),
                color: ATUColors.primaryBlue,
              ),
              IconButton(
                onPressed: () => _deleteQuestion(index),
                icon: const Icon(Icons.delete_rounded),
                color: ATUColors.error,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Q${index + 1}. ${question.question}',
            style: ATUTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey900,
            ),
          ),
          if (question.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              question.description,
              style: ATUTextStyles.bodySmall.copyWith(color: ATUColors.grey600),
            ),
          ],
          if (question.options.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: question.options.map((option) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ATUColors.grey100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    option,
                    style: ATUTextStyles.caption.copyWith(
                      color: ATUColors.grey700,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                question.isRequired
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
                size: 16,
                color: question.isRequired
                    ? ATUColors.warning
                    : ATUColors.grey400,
              ),
              const SizedBox(width: 4),
              Text(
                question.isRequired ? 'Required' : 'Optional',
                style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Survey Targeting',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Define who should receive this survey',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey600),
          ),
          const SizedBox(height: 24),

          // Open to all toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ATUColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ATUColors.grey200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Open to All Alumni',
                        style: ATUTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ATUColors.grey900,
                        ),
                      ),
                      Text(
                        'Send survey to all registered alumni',
                        style: ATUTextStyles.bodySmall.copyWith(
                          color: ATUColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _targeting.isOpenToAll,
                  onChanged: (value) {
                    setState(() {
                      _targeting = SurveyTargeting(
                        isOpenToAll: value,
                        graduationYears: value
                            ? []
                            : _targeting.graduationYears,
                        programs: value ? [] : _targeting.programs,
                        faculties: value ? [] : _targeting.faculties,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          if (!_targeting.isOpenToAll) ...[
            const SizedBox(height: 24),

            // Graduation years
            Text(
              'Graduation Years',
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: ATUColors.grey700,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultiSelectChips(
              items: ['2020', '2021', '2022', '2023', '2024'],
              selectedItems: _targeting.graduationYears
                  .map((e) => e.toString())
                  .toList(),
              onSelectionChanged: (selected) {
                setState(() {
                  _targeting = SurveyTargeting(
                    isOpenToAll: _targeting.isOpenToAll,
                    graduationYears: selected.map((e) => int.parse(e)).toList(),
                    programs: _targeting.programs,
                    faculties: _targeting.faculties,
                  );
                });
              },
            ),

            const SizedBox(height: 20),

            // Programs
            Text(
              'Programs',
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: ATUColors.grey700,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultiSelectChips(
              items: [
                'Computer Science',
                'Engineering',
                'Business Administration',
                'Architecture',
              ],
              selectedItems: _targeting.programs,
              onSelectionChanged: (selected) {
                setState(() {
                  _targeting = SurveyTargeting(
                    isOpenToAll: _targeting.isOpenToAll,
                    graduationYears: _targeting.graduationYears,
                    programs: selected,
                    faculties: _targeting.faculties,
                  );
                });
              },
            ),
          ],

          const SizedBox(height: 32),

          // Target summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ATUColors.primaryBlue.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ATUColors.primaryBlue.withValues(alpha: .3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Target Summary',
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ATUColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _targeting.isOpenToAll
                      ? 'This survey will be sent to all registered alumni (~2,847 users)'
                      : 'This survey will be sent to ${_calculateTargetCount()} alumni based on your filters',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Survey Settings',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 24),

          // Settings list
          _buildSettingItem(
            'Require Login',
            'Users must be logged in to respond',
            _settings.requireLogin,
            (value) {
              setState(() {
                _settings = SurveySettings(
                  requireLogin: value,
                  allowMultipleResponses: _settings.allowMultipleResponses,
                  showProgressBar: _settings.showProgressBar,
                  allowBackNavigation: _settings.allowBackNavigation,
                  randomizeQuestions: _settings.randomizeQuestions,
                );
              });
            },
          ),

          _buildSettingItem(
            'Allow Multiple Responses',
            'Users can submit multiple responses',
            _settings.allowMultipleResponses,
            (value) {
              setState(() {
                _settings = SurveySettings(
                  requireLogin: _settings.requireLogin,
                  allowMultipleResponses: value,
                  showProgressBar: _settings.showProgressBar,
                  allowBackNavigation: _settings.allowBackNavigation,
                  randomizeQuestions: _settings.randomizeQuestions,
                );
              });
            },
          ),

          _buildSettingItem(
            'Show Progress Bar',
            'Display completion progress to users',
            _settings.showProgressBar,
            (value) {
              setState(() {
                _settings = SurveySettings(
                  requireLogin: _settings.requireLogin,
                  allowMultipleResponses: _settings.allowMultipleResponses,
                  showProgressBar: value,
                  allowBackNavigation: _settings.allowBackNavigation,
                  randomizeQuestions: _settings.randomizeQuestions,
                );
              });
            },
          ),

          _buildSettingItem(
            'Allow Back Navigation',
            'Users can go back to previous questions',
            _settings.allowBackNavigation,
            (value) {
              setState(() {
                _settings = SurveySettings(
                  requireLogin: _settings.requireLogin,
                  allowMultipleResponses: _settings.allowMultipleResponses,
                  showProgressBar: _settings.showProgressBar,
                  allowBackNavigation: value,
                  randomizeQuestions: _settings.randomizeQuestions,
                );
              });
            },
          ),

          _buildSettingItem(
            'Randomize Questions',
            'Show questions in random order',
            _settings.randomizeQuestions,
            (value) {
              setState(() {
                _settings = SurveySettings(
                  requireLogin: _settings.requireLogin,
                  allowMultipleResponses: _settings.allowMultipleResponses,
                  showProgressBar: _settings.showProgressBar,
                  allowBackNavigation: _settings.allowBackNavigation,
                  randomizeQuestions: value,
                );
              });
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildMultiSelectChips({
    required List<String> items,
    required List<String> selectedItems,
    required Function(List<String>) onSelectionChanged,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return GestureDetector(
          onTap: () {
            List<String> newSelection = List.from(selectedItems);
            if (isSelected) {
              newSelection.remove(item);
            } else {
              newSelection.add(item);
            }
            onSelectionChanged(newSelection);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? ATUColors.primaryBlue : ATUColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? ATUColors.primaryBlue : ATUColors.grey300,
              ),
            ),
            child: Text(
              item,
              style: ATUTextStyles.bodySmall.copyWith(
                color: isSelected ? ATUColors.white : ATUColors.grey700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSettingItem(
    String title,
    String description,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ATUColors.grey200),
      ),
      child: Row(
        children: [
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
                Text(
                  description,
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) => AddQuestionDialog(
        onQuestionAdded: (question) {
          setState(() {
            _questions.add(question);
          });
        },
      ),
    );
  }

  void _editQuestion(int index) {
    showDialog(
      context: context,
      builder: (context) => AddQuestionDialog(
        existingQuestion: _questions[index],
        onQuestionAdded: (question) {
          setState(() {
            _questions[index] = question;
          });
        },
      ),
    );
  }

  void _deleteQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  int _calculateTargetCount() {
    // Mock calculation based on filters
    return 450; // This would be calculated based on actual data
  }

  String _getSurveyTypeLabel(SurveyType type) {
    switch (type) {
      case SurveyType.employmentStatus:
        return 'Employment Status';
      case SurveyType.careerProgression:
        return 'Career Progression';
      case SurveyType.skillsAssessment:
        return 'Skills Assessment';
      case SurveyType.programEvaluation:
        return 'Program Evaluation';
      case SurveyType.generalFeedback:
        return 'General Feedback';
      case SurveyType.custom:
        return 'Custom Survey';
    }
  }

  String _getSurveyTypeDescription(SurveyType type) {
    switch (type) {
      case SurveyType.employmentStatus:
        return 'Track alumni employment status, salary, and job satisfaction. Ideal for measuring career outcomes.';
      case SurveyType.careerProgression:
        return 'Monitor how alumni advance in their careers over time. Great for long-term impact assessment.';
      case SurveyType.skillsAssessment:
        return 'Evaluate skill gaps and training needs. Helps improve curriculum and professional development.';
      case SurveyType.programEvaluation:
        return 'Gather feedback on academic programs and their effectiveness in preparing graduates.';
      case SurveyType.generalFeedback:
        return 'Collect general opinions and suggestions from alumni about their experience.';
      case SurveyType.custom:
        return 'Create a custom survey for specific research needs or unique requirements.';
    }
  }

  String _getQuestionTypeLabel(QuestionType type) {
    switch (type) {
      case QuestionType.text:
        return 'Text';
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.dropdown:
        return 'Dropdown';
      case QuestionType.rating:
        return 'Rating';
      case QuestionType.scale:
        return 'Scale';
      case QuestionType.checkbox:
        return 'Checkbox';
      case QuestionType.date:
        return 'Date';
      case QuestionType.email:
        return 'Email';
      case QuestionType.number:
        return 'Number';
      case QuestionType.phone:
        return 'Phone';
      case QuestionType.file:
        return 'File Upload';
    }
  }

  Color _getQuestionTypeColor(QuestionType type) {
    switch (type) {
      case QuestionType.text:
      case QuestionType.email:
      case QuestionType.phone:
        return ATUColors.primaryBlue;
      case QuestionType.multipleChoice:
      case QuestionType.checkbox:
        return ATUColors.success;
      case QuestionType.dropdown:
        return ATUColors.info;
      case QuestionType.rating:
      case QuestionType.scale:
        return ATUColors.primaryGold;
      case QuestionType.date:
      case QuestionType.number:
        return ATUColors.warning;
      case QuestionType.file:
        return ATUColors.error;
    }
  }

  void _saveDraft() async {
    if (!_formKey.currentState!.validate()) {
      _tabController.animateTo(0);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Survey saved as draft'),
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

  void _publishSurvey() async {
    if (!_formKey.currentState!.validate()) {
      _tabController.animateTo(0);
      return;
    }

    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one question'),
          backgroundColor: ATUColors.warning,
        ),
      );
      _tabController.animateTo(1);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Survey published successfully'),
            backgroundColor: ATUColors.success,
          ),
        );
        Navigator.of(context).pop();
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

// Add Question Dialog
class AddQuestionDialog extends StatefulWidget {
  final SurveyQuestion? existingQuestion;
  final Function(SurveyQuestion) onQuestionAdded;

  const AddQuestionDialog({
    super.key,
    this.existingQuestion,
    required this.onQuestionAdded,
  });

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final _questionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _optionController = TextEditingController();

  QuestionType _selectedType = QuestionType.text;
  bool _isRequired = true;
  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingQuestion != null) {
      _loadExistingQuestion();
    }
  }

  void _loadExistingQuestion() {
    final question = widget.existingQuestion!;
    _questionController.text = question.question;
    _descriptionController.text = question.description;
    _selectedType = question.type;
    _isRequired = question.isRequired;
    _options = List.from(question.options);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.existingQuestion != null
                  ? 'Edit Question'
                  : 'Add Question',
              style: ATUTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ATUTextField(
                      label: 'Question',
                      hint: 'Enter your question',
                      controller: _questionController,
                    ),
                    const SizedBox(height: 16),

                    ATUTextField(
                      label: 'Description (Optional)',
                      hint: 'Add additional context or instructions',
                      controller: _descriptionController,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Question Type',
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
                        child: DropdownButton<QuestionType>(
                          value: _selectedType,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value!;
                              if (!_requiresOptions(value)) {
                                _options.clear();
                              }
                            });
                          },
                          items: QuestionType.values.map((type) {
                            return DropdownMenuItem<QuestionType>(
                              value: type,
                              child: Text(_getQuestionTypeLabel(type)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    if (_requiresOptions(_selectedType)) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Options',
                        style: ATUTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ATUColors.grey700,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: ATUTextField(
                              label: '',
                              hint: 'Enter an option',
                              controller: _optionController,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ATUButton(
                            text: 'Add',
                            onPressed: _addOption,
                            type: ATUButtonType.outline,
                            size: ATUButtonSize.small,
                          ),
                        ],
                      ),

                      if (_options.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        ...List.generate(_options.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: ATUColors.grey100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text(_options[index])),
                                IconButton(
                                  onPressed: () => _removeOption(index),
                                  icon: const Icon(Icons.close_rounded),
                                  iconSize: 18,
                                  color: ATUColors.error,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ],

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Checkbox(
                          value: _isRequired,
                          onChanged: (value) {
                            setState(() {
                              _isRequired = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'Required question',
                          style: ATUTextStyles.bodyMedium.copyWith(
                            color: ATUColors.grey700,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    text: widget.existingQuestion != null ? 'Update' : 'Add',
                    onPressed: _saveQuestion,
                    type: ATUButtonType.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _requiresOptions(QuestionType type) {
    return type == QuestionType.multipleChoice ||
        type == QuestionType.dropdown ||
        type == QuestionType.checkbox;
  }

  String _getQuestionTypeLabel(QuestionType type) {
    // Same implementation as in parent widget
    switch (type) {
      case QuestionType.text:
        return 'Text';
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.dropdown:
        return 'Dropdown';
      case QuestionType.rating:
        return 'Rating (1-5)';
      case QuestionType.scale:
        return 'Scale';
      case QuestionType.checkbox:
        return 'Checkbox';
      case QuestionType.date:
        return 'Date';
      case QuestionType.email:
        return 'Email';
      case QuestionType.number:
        return 'Number';
      case QuestionType.phone:
        return 'Phone';
      case QuestionType.file:
        return 'File Upload';
    }
  }

  void _addOption() {
    if (_optionController.text.isNotEmpty) {
      setState(() {
        _options.add(_optionController.text);
        _optionController.clear();
      });
    }
  }

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index);
    });
  }

  void _saveQuestion() {
    if (_questionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a question'),
          backgroundColor: ATUColors.error,
        ),
      );
      return;
    }

    if (_requiresOptions(_selectedType) && _options.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one option'),
          backgroundColor: ATUColors.error,
        ),
      );
      return;
    }

    final question = SurveyQuestion(
      id:
          widget.existingQuestion?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      question: _questionController.text,
      description: _descriptionController.text,
      type: _selectedType,
      options: _options,
      isRequired: _isRequired,
    );

    widget.onQuestionAdded(question);
    Navigator.of(context).pop();
  }
}
