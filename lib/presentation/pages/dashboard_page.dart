import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/data/models/user_profile_model.dart';
import 'package:sip_fit/presentation/providers/health_provider.dart';
import 'package:sip_fit/presentation/providers/user_profile_provider.dart';
import 'package:sip_fit/core/widgets/activity_list_item.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(healthProvider);
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header with logo and title
              _buildHeader(context),
              
              // Apple HealthKit Card
              _buildHealthKitCard(),
              
              // Cheers Points Card
              _buildCheersPointsCard(ref),
              
              // Drink Allowance Card
              _buildDrinkAllowanceCard(ref, userProfileAsync),
              
              // Recent Activities
              _buildRecentActivities(context, activitiesAsync),
              
              const SizedBox(height: 100), // Space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.textDark,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.flash_on,
              color: AppColors.primaryWhite,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // App Title
          Text(
            'Fit & Sip',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthKitCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // HealthKit Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.phone_android,
                  color: AppColors.accentGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // HealthKit Text
              const Text(
                'Apple HealthKit',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              // Sync Status
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.accentGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Synced',
                    style: TextStyle(
                      color: AppColors.accentGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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

  Widget _buildCheersPointsCard(WidgetRef ref) {
    final totalPointsAsync = ref.watch(totalPointsProvider);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryPurple,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(
                    Icons.flash_on,
                    color: AppColors.primaryWhite,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Cheers Points',
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Points Display
              totalPointsAsync.when(
                loading: () => const CircularProgressIndicator(color: AppColors.primaryWhite),
                error: (error, stack) => Text(
                  'Error: $error',
                  style: const TextStyle(color: AppColors.primaryWhite),
                ),
                data: (points) => Text(
                  points.toString(),
                  style: const TextStyle(
                    color: AppColors.primaryWhite,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Points Breakdown
              const Text(
                '🚶 10,000 steps = 50 points | 💪 1 workout = 25 points',
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrinkAllowanceCard(WidgetRef ref, AsyncValue<UserProfileModel?> userProfileAsync) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.warningOrange, width: 2),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: AppColors.warningOrange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Drink Allowance',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Wine Glass Visualization
              Center(
                child: Column(
                  children: [
                    // Wine Glass
                    Container(
                      width: 80,
                      height: 100,
                      child: Stack(
                        children: [
                          // Glass outline
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.textMedium, width: 2),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                          // Wine liquid (17% fill)
                          Positioned(
                            bottom: 0,
                            left: 2,
                            right: 2,
                            child: Container(
                              height: 13.6, // 17% of 80
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(38),
                                  bottomRight: Radius.circular(38),
                                ),
                              ),
                            ),
                          ),
                          // Glass stem
                          Positioned(
                            bottom: 0,
                            left: 50,
                            child: Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Glass base
                          Positioned(
                            bottom: 0,
                            left: 45,
                            child: Container(
                              width: 14,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Calorie Display
                    Text(
                      '168 / 1000 cal',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '17% of limit',
                      style: TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Progress Indicators
              Row(
                children: [
                  // Calorie Progress
                  Expanded(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: 0.17,
                                strokeWidth: 6,
                                backgroundColor: AppColors.borderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.warningOrange),
                              ),
                            ),
                            Text(
                              '17%',
                              style: TextStyle(
                                color: AppColors.warningOrange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '17%',
                          style: TextStyle(
                            color: AppColors.warningOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Calorie Progress',
                          style: TextStyle(
                            color: AppColors.warningOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Cups Progress
                  Expanded(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: 1.0,
                                strokeWidth: 6,
                                backgroundColor: AppColors.borderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.textDark),
                              ),
                            ),
                            Text(
                              '100%',
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '100%',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Cups (300ml)',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  Widget _buildRecentActivities(BuildContext context, AsyncValue<List<dynamic>> activitiesAsync) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          activitiesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
            data: (activities) => Column(
              children: activities
                  .take(3) // Show only 3 recent activities
                  .map((activity) => ActivityListItem(activity: activity))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
