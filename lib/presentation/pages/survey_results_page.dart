import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SurveyResultsPage extends ConsumerWidget {
  final Map<String, dynamic> responses;

  const SurveyResultsPage({
    super.key,
    required this.responses,
  });

  String _getExerciseGoal() {
    switch (responses['fitnessGoal']) {
      case 'weight_loss':
        return '''Your Exercise Goal:
• 30-45 minutes of cardio, 4-5 times per week
• Focus on HIIT and endurance training
• Target heart rate: 65-75% of max
• Include strength training 2-3 times per week
• Weekly calorie burn target: 2000-2500''';
      case 'maintenance':
        return '''Your Exercise Goal:
• 30 minutes of moderate activity, 5 times per week
• Mix of cardio and strength training
• Target heart rate: 60-70% of max
• Include flexibility work 2-3 times per week
• Weekly calorie burn target: 1500-2000''';
      case 'muscle_gain':
        return '''Your Exercise Goal:
• 45-60 minutes of strength training, 4 times per week
• Focus on progressive overload
• Include light cardio for recovery
• Proper form and technique priority
• Weekly calorie burn target: 1800-2200''';
      default:
        return 'Exercise goal not set';
    }
  }

  String _getDrinkingPlan() {
    final style = responses['drinkStyle'];
    final sweetness = responses['sweetnessLevel'];
    final carbonated = responses['likesCarbonated'];
    final dietary = responses['mainDietaryRestriction'];

    String base = '''Your Personalized Drinking Plan:
• Daily hydration target: 2.5-3L
• Pre-workout: ''';

    if (style == 'refreshing') {
      base += carbonated == true
          ? 'Sparkling citrus energizer'
          : 'Cucumber mint refresher';
    } else if (style == 'creamy') {
      base += dietary == 'vegan'
          ? 'Almond protein smoothie'
          : 'Greek yogurt protein shake';
    } else {
      base += 'Green tea with ginger';
    }

    base += '\n• During workout: Electrolyte-enhanced water';

    base += '\n• Post-workout: ';
    if (sweetness == 'low') {
      base += 'Berry-infused recovery drink';
    } else if (sweetness == 'medium') {
      base += 'Tropical smoothie blend';
    } else {
      base += 'Chocolate protein recovery shake';
    }

    base += '\n• Evening wind-down: ';
    if (dietary == 'low_sugar') {
      base += 'Sugar-free herbal infusion';
    } else {
      base += 'Chamomile honey tea';
    }

    return base;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildExerciseGoal(context),
                const SizedBox(height: 24),
                _buildDrinkingPlan(context),
                const SizedBox(height: 32),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.purpleToPinkGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            AppIcons.sparkles,
            color: AppColors.textWhite,
            size: 40,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Your Personalized Plan',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "We've created a custom plan based on your preferences",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildExerciseGoal(BuildContext context) {
    return GradientContainer(
      colors: AppColors.blueToIndigoGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                AppIcons.dumbbell,
                color: AppColors.textWhite,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Exercise Goal',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _getExerciseGoal(),
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideX(begin: -0.2, end: 0);
  }

  Widget _buildDrinkingPlan(BuildContext context) {
    return GradientContainer(
      colors: AppColors.purpleToOrangeGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                AppIcons.wine,
                color: AppColors.textWhite,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Drinking Plan',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _getDrinkingPlan(),
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideX(begin: 0.2, end: 0);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
            icon: Icon(
              AppIcons.sparkles,
              color: AppColors.textWhite,
            ),
            label: Text(
              'Start Your Journey',
              style: TextStyle(
                color: AppColors.textWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}
