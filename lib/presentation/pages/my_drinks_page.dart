import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/data/models/cocktail_model.dart';
import 'package:sip_fit/data/models/user_profile_model.dart';
import 'package:sip_fit/data/models/fitness_drink_preferences_model.dart';
import 'package:sip_fit/presentation/providers/daily_drinks_provider.dart';
import 'package:sip_fit/presentation/providers/user_profile_provider.dart';
import 'package:sip_fit/presentation/providers/fitness_drink_preferences_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyDrinksPage extends ConsumerStatefulWidget {
  const MyDrinksPage({super.key});

  @override
  ConsumerState<MyDrinksPage> createState() => _MyDrinksPageState();
}

class _MyDrinksPageState extends ConsumerState<MyDrinksPage> {
  final TextEditingController _drinkInputController = TextEditingController();
  bool _showDrinkInput = false;

  @override
  void dispose() {
    _drinkInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(userProfileProvider);
    final preferencesAsync = ref.watch(fitnessDrinkPreferencesProvider);
    final dailyDrinksAsync = ref.watch(dailyDrinksProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with drink input
              _buildHeader(),
              
              // Daily drink input
              if (_showDrinkInput) _buildDrinkInput(),
              
              // Today's drinks
              _buildTodaysDrinks(dailyDrinksAsync),
              
              // Recommended cocktails
              _buildRecommendedCocktails(userProfileAsync, preferencesAsync),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Drinks',
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showDrinkInput = !_showDrinkInput;
                  });
                },
                icon: Icon(
                  _showDrinkInput ? Icons.close : Icons.add,
                  color: AppColors.primaryWhite,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'What have you sipped today? 🍸',
                textStyle: TextStyle(
                  color: AppColors.primaryWhite.withOpacity(0.9),
                  fontSize: 18,
                ),
                speed: const Duration(milliseconds: 50),
              ),
            ],
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: -0.2, end: 0);
  }

  Widget _buildDrinkInput() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
        children: [
          TextField(
            controller: _drinkInputController,
            decoration: InputDecoration(
              hintText: 'Tell Sippy what you just had...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryPurple, width: 2),
              ),
              prefixIcon: Icon(Icons.local_bar, color: AppColors.primaryPurple),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement drink logging
              setState(() {
                _showDrinkInput = false;
              });
              _drinkInputController.clear();
            },
            icon: const Icon(Icons.check),
            label: const Text('Log Drink'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: AppColors.primaryWhite,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildTodaysDrinks(AsyncValue<List<CocktailModel>> dailyDrinksAsync) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Drinks",
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          dailyDrinksAsync.when(
            data: (drinks) {
              if (drinks.isEmpty) {
                return Center(
                  child: Text(
                    'No drinks logged today. Time to hydrate! 💧',
                    style: TextStyle(
                      color: AppColors.textMedium,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  final drink = drinks[index];
                  return _buildDrinkCard(drink);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCocktails(
    AsyncValue<UserProfileModel?> userProfileAsync,
    AsyncValue<FitnessDrinkPreferencesModel?> preferencesAsync,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended for You',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          userProfileAsync.when(
            data: (profile) => preferencesAsync.when(
              data: (preferences) {
                if (profile == null || preferences == null) {
                  return const Center(
                    child: Text('Complete your profile to get personalized recommendations'),
                  );
                }
                final recommendations = ref
                    .read(dailyDrinksProvider.notifier)
                    .getRecommendations(profile, preferences);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    return _buildCocktailCard(recommendations[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkCard(CocktailModel drink) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Text(
          drink.imageEmoji,
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(
          drink.name,
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${drink.calories} cal • ${drink.isAlcoholic ? "${drink.alcoholContent}% ABV" : "Non-alcoholic"}',
          style: TextStyle(
            color: AppColors.textMedium,
          ),
        ),
        trailing: Icon(
          Icons.check_circle,
          color: AppColors.accentGreen,
        ),
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .slideX(begin: 0.1, end: 0);
  }

  Widget _buildCocktailCard(CocktailModel cocktail) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryPurple.withOpacity(0.1),
              AppColors.accentPurple.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                cocktail.imageEmoji,
                style: const TextStyle(fontSize: 48),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              cocktail.name,
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              cocktail.description,
              style: TextStyle(
                color: AppColors.textMedium,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cocktail.calories} cal',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (cocktail.isAlcoholic)
                  Text(
                    '${cocktail.alcoholContent}%',
                    style: TextStyle(
                      color: AppColors.textMedium,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: cocktail.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: AppColors.primaryPurple,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}
