import 'package:json_annotation/json_annotation.dart';

part 'fitness_drink_preferences_model.g.dart';

enum DrinkFitnessGoal {
  weightLoss,
  maintenance,
  muscleGain
}

enum SweetnessLevel {
  low,
  medium,
  high
}

enum DrinkStyle {
  refreshing,
  creamy,
  warming
}

enum DietaryRestriction {
  none,
  vegan,
  dairyFree,
  lowSugar
}

@JsonSerializable()
class FitnessDrinkPreferencesModel {
  final String userId;
  final DrinkFitnessGoal fitnessGoal;
  final SweetnessLevel sweetnessLevel;
  final DrinkStyle drinkStyle;
  final DietaryRestriction mainDietaryRestriction;
  final bool likesCarbonated;
  final DateTime createdAt;
  final DateTime? updatedAt;

  FitnessDrinkPreferencesModel({
    required this.userId,
    required this.fitnessGoal,
    required this.sweetnessLevel,
    required this.drinkStyle,
    required this.mainDietaryRestriction,
    required this.likesCarbonated,
    required this.createdAt,
    this.updatedAt,
  });

  factory FitnessDrinkPreferencesModel.fromJson(Map<String, dynamic> json) => 
      _$FitnessDrinkPreferencesModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$FitnessDrinkPreferencesModelToJson(this);

  // Get display text for fitness goal
  String get fitnessGoalText {
    switch (fitnessGoal) {
      case DrinkFitnessGoal.weightLoss:
        return 'Weight Loss';
      case DrinkFitnessGoal.maintenance:
        return 'Maintenance';
      case DrinkFitnessGoal.muscleGain:
        return 'Muscle Gain';
    }
  }

  // Get display text for sweetness level
  String get sweetnessLevelText {
    switch (sweetnessLevel) {
      case SweetnessLevel.low:
        return 'Low Sweetness';
      case SweetnessLevel.medium:
        return 'Medium Sweetness';
      case SweetnessLevel.high:
        return 'High Sweetness';
    }
  }

  // Get display text for drink style
  String get drinkStyleText {
    switch (drinkStyle) {
      case DrinkStyle.refreshing:
        return 'Refreshing';
      case DrinkStyle.creamy:
        return 'Creamy';
      case DrinkStyle.warming:
        return 'Warming';
    }
  }

  // Get display text for dietary restriction
  String get dietaryRestrictionText {
    switch (mainDietaryRestriction) {
      case DietaryRestriction.none:
        return 'None';
      case DietaryRestriction.vegan:
        return 'Vegan';
      case DietaryRestriction.dairyFree:
        return 'Dairy Free';
      case DietaryRestriction.lowSugar:
        return 'Low Sugar';
    }
  }

  // Get display text for carbonation preference
  String get carbonatedPreferenceText {
    return likesCarbonated ? 'Carbonated' : 'Non-carbonated';
  }

  // Create a copy with updated fields
  FitnessDrinkPreferencesModel copyWith({
    String? userId,
    DrinkFitnessGoal? fitnessGoal,
    SweetnessLevel? sweetnessLevel,
    DrinkStyle? drinkStyle,
    DietaryRestriction? mainDietaryRestriction,
    bool? likesCarbonated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FitnessDrinkPreferencesModel(
      userId: userId ?? this.userId,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      sweetnessLevel: sweetnessLevel ?? this.sweetnessLevel,
      drinkStyle: drinkStyle ?? this.drinkStyle,
      mainDietaryRestriction: mainDietaryRestriction ?? this.mainDietaryRestriction,
      likesCarbonated: likesCarbonated ?? this.likesCarbonated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
