import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/presentation/providers/rewards_provider.dart';
import 'package:sip_fit/presentation/providers/health_provider.dart';

class RewardsPage extends ConsumerWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardsAsync = ref.watch(rewardsProvider);
    final totalPointsAsync = ref.watch(totalPointsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header with logo and title
              _buildHeader(context),
              
              // Cheers Out Section
              _buildCheersOutSection(),
              
              // Points Available
              _buildPointsAvailable(ref, totalPointsAsync),
              
              // Partner Bars
              _buildPartnerBars(context, ref, rewardsAsync),
              
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

  Widget _buildCheersOutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Title
          Row(
            children: [
              Text(
                'Cheers Out!',
                style: TextStyle(
                  color: AppColors.errorRed,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.local_bar,
                color: AppColors.primaryPink,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Description
          Text(
            'Redeem your Cheers Points at health-conscious partner bars',
            style: TextStyle(
              color: AppColors.textMedium,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsAvailable(WidgetRef ref, AsyncValue<int> totalPointsAsync) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.warningOrange,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.flash_on,
                color: AppColors.primaryWhite,
                size: 20,
              ),
              const SizedBox(width: 8),
              totalPointsAsync.when(
                loading: () => const Text(
                  'Loading...',
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                error: (error, stack) => Text(
                  'Error: $error',
                  style: const TextStyle(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                data: (points) => Text(
                  '$points points available',
                  style: const TextStyle(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerBars(BuildContext context, WidgetRef ref, AsyncValue<List<dynamic>> rewardsAsync) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: rewardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (rewards) => Column(
          children: [
            // GreenFit Bar & Grill
            _buildPartnerBarCard(
              context: context,
              barName: 'GreenFit Bar & Grill',
              address: '123 Wellness Ave',
              distance: '0.3 miles',
              rating: 4.8,
              specialty: 'Plant-based cocktails',
              rewards: rewards.take(2).toList(), // First 2 rewards
            ),
            
            const SizedBox(height: 20),
            
            // The Balanced Tap
            _buildPartnerBarCard(
              context: context,
              barName: 'The Balanced Tap',
              address: '456 Fitness Blvd',
              distance: '0.7 miles',
              rating: 4.6,
              specialty: 'Low-calorie cocktails',
              rewards: rewards.skip(2).take(2).toList(), // Next 2 rewards
            ),
            
            const SizedBox(height: 20),
            
            // FitSip Lounge
            _buildPartnerBarCard(
              context: context,
              barName: 'FitSip Lounge',
              address: '789 Active Street',
              distance: '1.2 miles',
              rating: 4.9,
              specialty: 'Athletic recovery drinks',
              rewards: rewards.skip(4).take(1).toList(), // Last reward
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerBarCard({
    required BuildContext context,
    required String barName,
    required String address,
    required String distance,
    required double rating,
    required String specialty,
    required List<dynamic> rewards,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bar Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.textLight,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            address,
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ' • $distance',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Specialty Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                specialty,
                style: TextStyle(
                  color: AppColors.accentGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Rewards List
            ...rewards.map((reward) => _buildRewardItem(context, reward)),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(BuildContext context, dynamic reward) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          // Drink Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.local_drink,
              color: AppColors.accentGreen,
              size: 30,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Drink Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.drinkName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reward.couponDetails,
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${reward.requiredPoints ~/ 10}', // Convert points to approximate price
                  style: TextStyle(
                    color: AppColors.warningOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Points and Redeem Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    color: AppColors.warningOrange,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${reward.requiredPoints}',
                    style: TextStyle(
                      color: AppColors.warningOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showRedeemConfirmation(context, reward),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warningOrange,
                  foregroundColor: AppColors.primaryWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text(
                  'Redeem',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRedeemConfirmation(BuildContext context, dynamic reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Redemption'),
        content: Text(
          'Redeem ${reward.drinkName} for ${reward.requiredPoints} points?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully redeemed ${reward.drinkName}!'),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            },
            child: const Text('Redeem'),
          ),
        ],
      ),
    );
  }
}
