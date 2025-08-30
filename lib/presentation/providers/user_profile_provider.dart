import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/user_profile_model.dart';

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfileModel?>>((ref) {
  return UserProfileNotifier();
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfileModel?>> {
  UserProfileNotifier() : super(const AsyncValue.data(null));

  Future<void> createProfile({
    required String userId,
    required int age,
    required double weight,
    required FitnessGoal fitnessGoal,
    required ActivityLevel activityLevel,
    required DrinkingControlGoal drinkingControlGoal,
    required int weeklyDrinkLimit,
    required int dailyCalorieLimit,
    required List<MotivationFactor> motivations,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      final profile = UserProfileModel(
        userId: userId,
        age: age,
        weight: weight,
        fitnessGoal: fitnessGoal,
        activityLevel: activityLevel,
        drinkingControlGoal: drinkingControlGoal,
        weeklyDrinkLimit: weeklyDrinkLimit,
        dailyCalorieLimit: dailyCalorieLimit,
        motivations: motivations,
        createdAt: DateTime.now(),
      );
      
      state = AsyncValue.data(profile);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateProfile({
    int? age,
    double? weight,
    FitnessGoal? fitnessGoal,
    ActivityLevel? activityLevel,
    DrinkingControlGoal? drinkingControlGoal,
    int? weeklyDrinkLimit,
    int? dailyCalorieLimit,
    List<MotivationFactor>? motivations,
  }) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      final updatedProfile = UserProfileModel(
        userId: currentProfile.userId,
        age: age ?? currentProfile.age,
        weight: weight ?? currentProfile.weight,
        fitnessGoal: fitnessGoal ?? currentProfile.fitnessGoal,
        activityLevel: activityLevel ?? currentProfile.activityLevel,
        drinkingControlGoal: drinkingControlGoal ?? currentProfile.drinkingControlGoal,
        weeklyDrinkLimit: weeklyDrinkLimit ?? currentProfile.weeklyDrinkLimit,
        dailyCalorieLimit: dailyCalorieLimit ?? currentProfile.dailyCalorieLimit,
        motivations: motivations ?? currentProfile.motivations,
        createdAt: currentProfile.createdAt,
        updatedAt: DateTime.now(),
      );
      
      state = AsyncValue.data(updatedProfile);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearProfile() {
    state = const AsyncValue.data(null);
  }
}
