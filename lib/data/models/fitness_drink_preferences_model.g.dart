// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_drink_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessDrinkPreferencesModel _$FitnessDrinkPreferencesModelFromJson(
  Map<String, dynamic> json,
) => FitnessDrinkPreferencesModel(
  userId: json['userId'] as String,
  fitnessGoal: $enumDecode(_$DrinkFitnessGoalEnumMap, json['fitnessGoal']),
  sweetnessLevel: $enumDecode(_$SweetnessLevelEnumMap, json['sweetnessLevel']),
  drinkStyle: $enumDecode(_$DrinkStyleEnumMap, json['drinkStyle']),
  mainDietaryRestriction: $enumDecode(
    _$DietaryRestrictionEnumMap,
    json['mainDietaryRestriction'],
  ),
  likesCarbonated: json['likesCarbonated'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FitnessDrinkPreferencesModelToJson(
  FitnessDrinkPreferencesModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'fitnessGoal': _$DrinkFitnessGoalEnumMap[instance.fitnessGoal]!,
  'sweetnessLevel': _$SweetnessLevelEnumMap[instance.sweetnessLevel]!,
  'drinkStyle': _$DrinkStyleEnumMap[instance.drinkStyle]!,
  'mainDietaryRestriction':
      _$DietaryRestrictionEnumMap[instance.mainDietaryRestriction]!,
  'likesCarbonated': instance.likesCarbonated,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$DrinkFitnessGoalEnumMap = {
  DrinkFitnessGoal.weightLoss: 'weightLoss',
  DrinkFitnessGoal.maintenance: 'maintenance',
  DrinkFitnessGoal.muscleGain: 'muscleGain',
};

const _$SweetnessLevelEnumMap = {
  SweetnessLevel.low: 'low',
  SweetnessLevel.medium: 'medium',
  SweetnessLevel.high: 'high',
};

const _$DrinkStyleEnumMap = {
  DrinkStyle.refreshing: 'refreshing',
  DrinkStyle.creamy: 'creamy',
  DrinkStyle.warming: 'warming',
};

const _$DietaryRestrictionEnumMap = {
  DietaryRestriction.none: 'none',
  DietaryRestriction.vegan: 'vegan',
  DietaryRestriction.dairyFree: 'dairyFree',
  DietaryRestriction.lowSugar: 'lowSugar',
};
