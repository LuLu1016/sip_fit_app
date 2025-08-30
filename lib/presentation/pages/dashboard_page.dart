import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:sip_fit/core/widgets/drink_glass_indicator.dart';
import 'package:sip_fit/core/widgets/dumbbell_indicator.dart';
import 'package:sip_fit/core/widgets/workout_record_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final TextEditingController _drinkInputController = TextEditingController();
  bool _showDrinkInput = false;

  // Mock data - Replace with actual providers
  final List<String> dailyGoals = [
    "Today's mission: Fuel your body with intention and crush every rep! 💪",
    "Let's make today legendary - every sip and every step counts! 🚀",
    "Your future self will thank you for the choices you make today! ✨",
    "Today is your canvas - paint it with sweat, hydration, and victory! 🎨",
  ];

  final Map<String, dynamic> userStats = {
    'drinkAllowance': 850,
    'drinkConsumed': 320,
    'workoutCalories': 280,
    'points': 1250,
  };

  final List<Map<String, dynamic>> workoutHistory = [
    {
      'type': 'Morning Run',
      'duration': '45 min',
      'calories': 320,
      'points': 150,
      'time': DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      'type': 'Strength Training',
      'duration': '30 min',
      'calories': 180,
      'points': 100,
      'time': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'type': 'Yoga',
      'duration': '20 min',
      'calories': 80,
      'points': 50,
      'time': DateTime.now().subtract(const Duration(hours: 8)),
    },
  ];

  @override
  void dispose() {
    _drinkInputController.dispose();
    super.dispose();
  }

  String get todaysGoal {
    final dayOfWeek = DateTime.now().weekday;
    return dailyGoals[dayOfWeek % dailyGoals.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Daily Goal
              _buildDailyGoal(),
              
              // Stats Grid
              _buildStatsGrid(),
              
              // Drink Input
              if (_showDrinkInput) _buildDrinkInput(),
              
              // Quick Add Button
              if (!_showDrinkInput) _buildQuickAddButton(),
              
              _buildWorkoutHistory(),
              const SizedBox(height: 100), // Space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.purpleToPinkGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  AppIcons.sparkles,
                  color: AppColors.textWhite,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FitDrink',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Hey Alex! 👋',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  AppIcons.gift,
                  color: AppColors.primaryPurple,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '${userStats['points']} pts',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildDailyGoal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GradientContainer(
        colors: AppColors.purpleToOrangeGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  AppIcons.target,
                  color: AppColors.textWhite,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  "Today's Mission",
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  todaysGoal,
                  textStyle: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600)).slideY(begin: -0.2, end: 0);
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Drink Budget',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Icon(
                        AppIcons.wine,
                        color: AppColors.primaryPink,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DrinkGlassIndicator(
                    consumed: userStats['drinkConsumed'].toDouble(),
                    total: userStats['drinkAllowance'].toDouble(),
                    label: 'calories',
                    unit: 'left',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Burned Today',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Icon(
                        AppIcons.dumbbell,
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DumbbellIndicator(
                    calories: userStats['workoutCalories'],
                    label: 'calories',
                    unit: 'burned',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600)).slideY(begin: 0.2, end: 0);
  }

  Widget _buildWorkoutHistory() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Workouts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ...workoutHistory.map(
            (workout) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WorkoutRecordCard(
                type: workout['type'],
                duration: workout['duration'],
                calories: workout['calories'],
                points: workout['points'],
                time: workout['time'],
              ),
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildQuickAddButton() {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            _showDrinkInput = true;
          });
        },
        icon: Icon(
          AppIcons.plus,
          color: AppColors.primaryPurple,
        ),
        label: Text(
          'Log a drink',
          style: TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 300));
  }

  Widget _buildDrinkInput() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.1),
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
              Icon(
                AppIcons.plus,
                color: AppColors.successGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'What did you drink today?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _drinkInputController,
                  decoration: InputDecoration(
                    hintText: 'e.g., I drank 300ml mojito',
                    prefixIcon: Icon(
                      AppIcons.wine,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle drink logging
                  setState(() {
                    _showDrinkInput = false;
                  });
                  _drinkInputController.clear();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: AppColors.successGreen,
                ),
                child: Icon(
                  AppIcons.send,
                  color: AppColors.textWhite,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}