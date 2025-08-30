import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/presentation/providers/fitness_drink_preferences_provider.dart';

class FitnessDrinkResultsPage extends ConsumerWidget {
  const FitnessDrinkResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesAsync = ref.watch(fitnessDrinkPreferencesProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Your Personalized Recommendations',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.backgroundCard,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      body: preferencesAsync.when(
        data: (preferences) {
          if (preferences == null) {
            return _buildNoPreferencesView();
          }
          return _buildResultsView(context, ref, preferences);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorView(error.toString()),
      ),
    );
  }

  Widget _buildNoPreferencesView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_cafe,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            'No drink preferences survey completed yet',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete the survey to see personalized recommendations',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView(BuildContext context, WidgetRef ref, dynamic preferences) {
    final notifier = ref.read(fitnessDrinkPreferencesProvider.notifier);
    final recommendedDrink = notifier.getRecommendedDrinkType();
    final personalizedTips = notifier.getPersonalizedTips();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 推荐饮品卡片
          _buildRecommendationCard(recommendedDrink),
          const SizedBox(height: 24),
          
          // 用户偏好总结
          _buildPreferencesSummary(preferences),
          const SizedBox(height: 24),
          
          // 个性化建议
          _buildPersonalizedTips(personalizedTips),
          const SizedBox(height: 24),
          
          // 操作按钮
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(String recommendedDrink) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryPurple, AppColors.accentPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              Icons.star,
              color: AppColors.primaryWhite,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Recommended for You',
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recommendedDrink,
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSummary(dynamic preferences) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.primaryPurple,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Your Preferences Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildPreferenceRow('Fitness Goal', preferences.fitnessGoalText),
            _buildPreferenceRow('Sweetness Level', preferences.sweetnessLevelText),
            _buildPreferenceRow('Drink Style', preferences.drinkStyleText),
            _buildPreferenceRow('Dietary Restrictions', preferences.dietaryRestrictionText),
            _buildPreferenceRow('Carbonation', preferences.carbonatedPreferenceText),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalizedTips(List<String> tips) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: AppColors.accentGreen,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Personalized Tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...tips.map((tip) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.accentGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textMedium,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // 重新进行调查
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: AppColors.primaryWhite,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Retake Survey',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // 分享结果
              _shareResults(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: AppColors.primaryPurple, width: 1.5),
            ),
            child: Text(
              'Share Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.errorRed,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading Failed',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _shareResults(BuildContext context) {
    // 这里可以实现分享功能
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share feature coming soon...'),
        backgroundColor: AppColors.primaryPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
