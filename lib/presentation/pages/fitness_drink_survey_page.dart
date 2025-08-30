import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FitnessDrinkSurveyPage extends ConsumerStatefulWidget {
  const FitnessDrinkSurveyPage({super.key});

  @override
  ConsumerState<FitnessDrinkSurveyPage> createState() => _FitnessDrinkSurveyPageState();
}

class _FitnessDrinkSurveyPageState extends ConsumerState<FitnessDrinkSurveyPage> {
  int _currentStep = 0;
  Map<String, dynamic> _responses = {
    'fitnessGoal': '',
    'sweetnessLevel': '',
    'drinkStyle': '',
    'mainDietaryRestriction': '',
    'likesCarbonated': null,
  };

  final List<Map<String, dynamic>> _questions = [
    {
      'id': 'fitnessGoal',
      'title': "What's your fitness goal?",
      'subtitle': 'This helps us recommend the perfect drinks for your journey',
      'icon': AppIcons.target,
      'options': [
        {
          'value': 'weight_loss',
          'label': 'Weight Loss',
          'emoji': '🔥',
          'desc': 'Burn calories and lean down',
        },
        {
          'value': 'maintenance',
          'label': 'Maintenance',
          'emoji': '⚖️',
          'desc': 'Stay healthy and balanced',
        },
        {
          'value': 'muscle_gain',
          'label': 'Muscle Gain',
          'emoji': '💪',
          'desc': 'Build strength and size',
        },
      ],
    },
    {
      'id': 'sweetnessLevel',
      'title': 'How sweet do you like it?',
      'subtitle': "We'll match your taste preferences perfectly",
      'icon': AppIcons.sparkles,
      'options': [
        {
          'value': 'low',
          'label': 'Low Sweetness',
          'emoji': '🌿',
          'desc': 'Subtle, natural flavors',
        },
        {
          'value': 'medium',
          'label': 'Medium Sweetness',
          'emoji': '🍯',
          'desc': 'Balanced and smooth',
        },
        {
          'value': 'high',
          'label': 'High Sweetness',
          'emoji': '🍭',
          'desc': 'Rich, indulgent taste',
        },
      ],
    },
    {
      'id': 'drinkStyle',
      'title': "What's your preferred drink style?",
      'subtitle': 'Choose the vibe that matches your mood',
      'icon': AppIcons.wine,
      'options': [
        {
          'value': 'refreshing',
          'label': 'Refreshing',
          'emoji': '💧',
          'desc': 'Light, crisp, and energizing',
        },
        {
          'value': 'creamy',
          'label': 'Creamy',
          'emoji': '🥛',
          'desc': 'Rich, smooth, and satisfying',
        },
        {
          'value': 'warming',
          'label': 'Warming',
          'emoji': '☕',
          'desc': 'Cozy, comforting, and soothing',
        },
      ],
    },
    {
      'id': 'mainDietaryRestriction',
      'title': 'Any dietary restrictions?',
      'subtitle': "We'll make sure every recommendation fits your needs",
      'icon': AppIcons.info,
      'options': [
        {
          'value': 'none',
          'label': 'None',
          'emoji': '✅',
          'desc': 'No restrictions',
        },
        {
          'value': 'vegan',
          'label': 'Vegan',
          'emoji': '🌱',
          'desc': 'Plant-based only',
        },
        {
          'value': 'dairy_free',
          'label': 'Dairy Free',
          'emoji': '🚫',
          'desc': 'No dairy products',
        },
        {
          'value': 'low_sugar',
          'label': 'Low Sugar',
          'emoji': '📉',
          'desc': 'Minimal sugar content',
        },
      ],
    },
    {
      'id': 'likesCarbonated',
      'title': 'Do you like carbonated drinks?',
      'subtitle': "Bubbles or no bubbles? We've got you covered",
      'icon': AppIcons.sparkles,
      'options': [
        {
          'value': true,
          'label': 'Yes, I love bubbles!',
          'emoji': '💫',
          'desc': 'Sparkling and fizzy',
        },
        {
          'value': false,
          'label': 'No, still drinks please',
          'emoji': '🌊',
          'desc': 'Smooth and still',
        },
      ],
    },
  ];

  void _handleOptionSelect(dynamic value) {
    setState(() {
      _responses[_questions[_currentStep]['id']] = value;
    });
  }

  void _nextStep() {
    if (_currentStep < _questions.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _showResults();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  bool _isStepComplete() {
    final currentValue = _responses[_questions[_currentStep]['id']];
    return currentValue != '' && currentValue != null;
  }

  void _showResults() {
    Navigator.pushReplacementNamed(
      context,
      '/survey_results',
      arguments: _responses,
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentStep + 1) / _questions.length;
    final currentQuestion = _questions[_currentStep];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProgressBar(progress),
                const SizedBox(height: 24),
                _buildQuestionCard(currentQuestion),
                const SizedBox(height: 24),
                _buildNavigationDots(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step ${_currentStep + 1} of ${_questions.length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${(progress * 100).round()}% complete',
              style: TextStyle(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.purpleToPinkGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return GradientContainer(
      colors: AppColors.purpleToOrangeGradient,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.textWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              question['icon'],
              color: AppColors.textWhite,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                question['title'],
                textStyle: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 50),
              ),
            ],
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
          ),
          const SizedBox(height: 8),
          Text(
            question['subtitle'],
            style: TextStyle(
              color: AppColors.textWhite.withOpacity(0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Column(
            children: question['options'].map<Widget>((option) {
              final isSelected = _responses[question['id']] == option['value'];
              return GestureDetector(
                onTap: () => _handleOptionSelect(option['value']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.textWhite
                        : AppColors.textWhite.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        option['emoji'],
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option['label'],
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primaryPurple
                                    : AppColors.textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              option['desc'],
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.textMedium
                                    : AppColors.textWhite.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.check,
                            color: AppColors.textWhite,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              ).animate()
                .fadeIn(duration: const Duration(milliseconds: 300))
                .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
            }).toList(),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _currentStep > 0 ? _prevStep : null,
                icon: Icon(
                  Icons.arrow_back,
                  color: _currentStep > 0
                      ? AppColors.textWhite
                      : AppColors.textWhite.withOpacity(0.5),
                ),
                label: Text(
                  'Back',
                  style: TextStyle(
                    color: _currentStep > 0
                        ? AppColors.textWhite
                        : AppColors.textWhite.withOpacity(0.5),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _isStepComplete() ? _nextStep : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textWhite,
                  foregroundColor: AppColors.primaryPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      _currentStep < _questions.length - 1 ? 'Next' : 'Complete',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _currentStep < _questions.length - 1
                          ? Icons.arrow_forward
                          : AppIcons.sparkles,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildNavigationDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _questions.length,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentStep
                ? AppColors.primaryPurple
                : index < _currentStep
                    ? AppColors.primaryPink
                    : AppColors.backgroundCard,
          ),
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600));
  }
}