// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_drink_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDrinkModel _$DailyDrinkModelFromJson(Map<String, dynamic> json) =>
    DailyDrinkModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      calories: (json['calories'] as num).toInt(),
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      nutritionFacts: json['nutritionFacts'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$DailyDrinkModelToJson(DailyDrinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'calories': instance.calories,
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'nutritionFacts': instance.nutritionFacts,
      'notes': instance.notes,
    };
