import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PointsPage extends ConsumerWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement points provider
    const currentPoints = 750;
    const nextRewardPoints = 1000;
    const pointsToNext = nextRewardPoints - currentPoints;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(currentPoints, pointsToNext),
              _buildNextReward(pointsToNext),
              _buildRewardsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int currentPoints, int pointsToNext) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryPurple, AppColors.accentPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Points',
            style: TextStyle(
              color: AppColors.primaryWhite,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryWhite.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Balance',
                      style: TextStyle(
                        color: AppColors.primaryWhite.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: AppColors.primaryWhite,
                          size: 32,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          currentPoints.toString(),
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$pointsToNext to next reward',
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: -0.2, end: 0);
  }

  Widget _buildNextReward(int pointsToNext) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
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
          Text(
            'Next Reward',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '🍸',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Free Signature Cocktail',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Only $pointsToNext points to go!',
                      style: TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.75, // currentPoints / nextRewardPoints
              backgroundColor: AppColors.borderColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
              minHeight: 8,
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildRewardsList() {
    final rewards = [
      {
        'name': 'Free Appetizer',
        'points': 500,
        'emoji': '🍱',
        'description': 'Any appetizer up to \$15',
      },
      {
        'name': 'Signature Cocktail',
        'points': 1000,
        'emoji': '🍸',
        'description': 'One free signature cocktail',
      },
      {
        'name': 'VIP Experience',
        'points': 2000,
        'emoji': '👑',
        'description': 'Skip the line + reserved seating',
      },
      {
        'name': 'Private Tasting',
        'points': 5000,
        'emoji': '✨',
        'description': 'Exclusive cocktail tasting for two',
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Rewards',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        reward['emoji'] as String,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  title: Text(
                    reward['name'] as String,
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    reward['description'] as String,
                    style: TextStyle(
                      color: AppColors.textMedium,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${reward['points']} pts',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ).animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 100 * index),
                )
                .slideX(begin: 0.2, end: 0);
            },
          ),
        ],
      ),
    );
  }
}
