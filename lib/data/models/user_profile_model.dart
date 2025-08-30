import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

enum FitnessGoal {
  loseWeight,
  maintainWeight,
  buildMuscle,
  generalFitness
}

enum ActivityLevel {
  sedentary,
  light,
  moderate,
  veryActive,
  extraActive
}

enum DrinkingControlGoal {
  reduceAlcohol,
  drinkModeration,
  socialDrinking,
  trackIntake
}

enum MotivationFactor {
  earnRewards,
  trackDrinking,
  socialAccountability,
  discoverPlaces,
  celebrateAchievements,
  healthImprovement
}

@JsonSerializable()
class UserProfileModel {
  final String userId;
  final int age;
  final double weight; // in lbs
  final FitnessGoal fitnessGoal;
  final ActivityLevel activityLevel;
  final DrinkingControlGoal drinkingControlGoal;
  final int weeklyDrinkLimit;
  final int dailyCalorieLimit;
  final List<MotivationFactor> motivations;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserProfileModel({
    required this.userId,
    required this.age,
    required this.weight,
    required this.fitnessGoal,
    required this.activityLevel,
    required this.drinkingControlGoal,
    required this.weeklyDrinkLimit,
    required this.dailyCalorieLimit,
    required this.motivations,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
