// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      userId: json['userId'] as String,
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      fitnessGoal: $enumDecode(_$FitnessGoalEnumMap, json['fitnessGoal']),
      activityLevel: $enumDecode(_$ActivityLevelEnumMap, json['activityLevel']),
      drinkingControlGoal: $enumDecode(
        _$DrinkingControlGoalEnumMap,
        json['drinkingControlGoal'],
      ),
      weeklyDrinkLimit: (json['weeklyDrinkLimit'] as num).toInt(),
      dailyCalorieLimit: (json['dailyCalorieLimit'] as num).toInt(),
      motivations: (json['motivations'] as List<dynamic>)
          .map((e) => $enumDecode(_$MotivationFactorEnumMap, e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'age': instance.age,
      'weight': instance.weight,
      'fitnessGoal': _$FitnessGoalEnumMap[instance.fitnessGoal]!,
      'activityLevel': _$ActivityLevelEnumMap[instance.activityLevel]!,
      'drinkingControlGoal':
          _$DrinkingControlGoalEnumMap[instance.drinkingControlGoal]!,
      'weeklyDrinkLimit': instance.weeklyDrinkLimit,
      'dailyCalorieLimit': instance.dailyCalorieLimit,
      'motivations': instance.motivations
          .map((e) => _$MotivationFactorEnumMap[e]!)
          .toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$FitnessGoalEnumMap = {
  FitnessGoal.loseWeight: 'loseWeight',
  FitnessGoal.maintainWeight: 'maintainWeight',
  FitnessGoal.buildMuscle: 'buildMuscle',
  FitnessGoal.generalFitness: 'generalFitness',
};

const _$ActivityLevelEnumMap = {
  ActivityLevel.sedentary: 'sedentary',
  ActivityLevel.light: 'light',
  ActivityLevel.moderate: 'moderate',
  ActivityLevel.veryActive: 'veryActive',
  ActivityLevel.extraActive: 'extraActive',
};

const _$DrinkingControlGoalEnumMap = {
  DrinkingControlGoal.reduceAlcohol: 'reduceAlcohol',
  DrinkingControlGoal.drinkModeration: 'drinkModeration',
  DrinkingControlGoal.socialDrinking: 'socialDrinking',
  DrinkingControlGoal.trackIntake: 'trackIntake',
};

const _$MotivationFactorEnumMap = {
  MotivationFactor.earnRewards: 'earnRewards',
  MotivationFactor.trackDrinking: 'trackDrinking',
  MotivationFactor.socialAccountability: 'socialAccountability',
  MotivationFactor.discoverPlaces: 'discoverPlaces',
  MotivationFactor.celebrateAchievements: 'celebrateAchievements',
  MotivationFactor.healthImprovement: 'healthImprovement',
};
