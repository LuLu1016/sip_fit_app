import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/fitness_drink_preferences_model.dart';

class FitnessDrinkPreferencesNotifier extends StateNotifier<AsyncValue<FitnessDrinkPreferencesModel?>> {
  FitnessDrinkPreferencesNotifier() : super(const AsyncValue.data(null));

  // Create new fitness drink preferences
  Future<void> createPreferences({
    required String userId,
    required String fitnessGoal,
    required String sweetnessLevel,
    required String drinkStyle,
    required String mainDietaryRestriction,
    required bool likesCarbonated,
  }) async {
    try {
      state = const AsyncValue.loading();
      
      // Convert string values to enums
      final fitnessGoalEnum = _parseFitnessGoal(fitnessGoal);
      final sweetnessLevelEnum = _parseSweetnessLevel(sweetnessLevel);
      final drinkStyleEnum = _parseDrinkStyle(drinkStyle);
      final dietaryRestrictionEnum = _parseDietaryRestriction(mainDietaryRestriction);

      final preferences = FitnessDrinkPreferencesModel(
        userId: userId,
        fitnessGoal: fitnessGoalEnum,
        sweetnessLevel: sweetnessLevelEnum,
        drinkStyle: drinkStyleEnum,
        mainDietaryRestriction: dietaryRestrictionEnum,
        likesCarbonated: likesCarbonated,
        createdAt: DateTime.now(),
      );

      // TODO: Add logic to save to local storage or API
      // For now, just update the state
      state = AsyncValue.data(preferences);
      
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Update fitness drink preferences
  Future<void> updatePreferences({
    DrinkFitnessGoal? fitnessGoal,
    SweetnessLevel? sweetnessLevel,
    DrinkStyle? drinkStyle,
    DietaryRestriction? mainDietaryRestriction,
    bool? likesCarbonated,
  }) async {
    try {
      final currentPreferences = state.value;
      if (currentPreferences == null) return;

      final updatedPreferences = currentPreferences.copyWith(
        fitnessGoal: fitnessGoal,
        sweetnessLevel: sweetnessLevel,
        drinkStyle: drinkStyle,
        mainDietaryRestriction: mainDietaryRestriction,
        likesCarbonated: likesCarbonated,
      );

      // TODO: Add logic to save to local storage or API
      state = AsyncValue.data(updatedPreferences);
      
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Clear fitness drink preferences
  void clearPreferences() {
    state = const AsyncValue.data(null);
  }

  // Parse fitness goal string to enum
  DrinkFitnessGoal _parseFitnessGoal(String value) {
    switch (value) {
      case 'weight_loss':
        return DrinkFitnessGoal.weightLoss;
      case 'maintenance':
        return DrinkFitnessGoal.maintenance;
      case 'muscle_gain':
        return DrinkFitnessGoal.muscleGain;
      default:
        return DrinkFitnessGoal.maintenance;
    }
  }

  // Parse sweetness level string to enum
  SweetnessLevel _parseSweetnessLevel(String value) {
    switch (value) {
      case 'low':
        return SweetnessLevel.low;
      case 'medium':
        return SweetnessLevel.medium;
      case 'high':
        return SweetnessLevel.high;
      default:
        return SweetnessLevel.medium;
    }
  }

  // Parse drink style string to enum
  DrinkStyle _parseDrinkStyle(String value) {
    switch (value) {
      case 'refreshing':
        return DrinkStyle.refreshing;
      case 'creamy':
        return DrinkStyle.creamy;
      case 'warming':
        return DrinkStyle.warming;
      default:
        return DrinkStyle.refreshing;
    }
  }

  // Parse dietary restriction string to enum
  DietaryRestriction _parseDietaryRestriction(String value) {
    switch (value) {
      case 'none':
        return DietaryRestriction.none;
      case 'vegan':
        return DietaryRestriction.vegan;
      case 'dairy_free':
        return DietaryRestriction.dairyFree;
      case 'low_sugar':
        return DietaryRestriction.lowSugar;
      default:
        return DietaryRestriction.none;
    }
  }

  // Get recommended drink type
  String getRecommendedDrinkType() {
    final preferences = state.value;
    if (preferences == null) return 'Classic Healthy Drink';

    // Recommend drink type based on user preferences
    if (preferences.fitnessGoal == DrinkFitnessGoal.weightLoss) {
      if (preferences.sweetnessLevel == SweetnessLevel.low) {
        return 'Low-calorie Green Tea';
      } else if (preferences.likesCarbonated) {
        return 'Sugar-free Sparkling Water';
      } else {
        return 'Lemon Water';
      }
    } else if (preferences.fitnessGoal == DrinkFitnessGoal.muscleGain) {
      if (preferences.drinkStyle == DrinkStyle.creamy) {
        return 'Protein Shake';
      } else {
        return 'Sports Energy Drink';
      }
    } else {
      if (preferences.drinkStyle == DrinkStyle.warming) {
        return 'Herbal Tea';
      } else {
        return 'Fruit Smoothie';
      }
    }
  }

  // Get personalized tips
  List<String> getPersonalizedTips() {
    final preferences = state.value;
    if (preferences == null) return ['Stay hydrated', 'Exercise moderately'];

    final tips = <String>[];

    // Tips based on fitness goal
    switch (preferences.fitnessGoal) {
      case DrinkFitnessGoal.weightLoss:
        tips.add('Choose low-calorie drinks');
        tips.add('Avoid sugary beverages');
        break;
      case DrinkFitnessGoal.muscleGain:
        tips.add('Increase protein intake');
        tips.add('Hydrate after workouts');
        break;
      case DrinkFitnessGoal.maintenance:
        tips.add('Maintain balanced diet');
        tips.add('Exercise regularly');
        break;
    }

    // Tips based on sweetness preference
    if (preferences.sweetnessLevel == SweetnessLevel.high) {
      tips.add('Consider natural sweeteners');
    }

    // Tips based on dietary restrictions
    if (preferences.mainDietaryRestriction == DietaryRestriction.vegan) {
      tips.add('Choose plant-based protein drinks');
    }

    return tips;
  }
}

// Provider
final fitnessDrinkPreferencesProvider = StateNotifierProvider<FitnessDrinkPreferencesNotifier, AsyncValue<FitnessDrinkPreferencesModel?>>(
  (ref) => FitnessDrinkPreferencesNotifier(),
);
