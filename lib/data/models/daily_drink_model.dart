import 'package:json_annotation/json_annotation.dart';

part 'daily_drink_model.g.dart';

@JsonSerializable()
class DailyDrinkModel {
  final String id;
  final String userId;
  final String name;
  final int calories;
  final String type; // 'cocktail', 'mocktail', 'water', etc.
  final DateTime timestamp;
  final Map<String, dynamic>? nutritionFacts;
  final String? notes;

  DailyDrinkModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.calories,
    required this.type,
    required this.timestamp,
    this.nutritionFacts,
    this.notes,
  });

  factory DailyDrinkModel.fromJson(Map<String, dynamic> json) => _$DailyDrinkModelFromJson(json);
  Map<String, dynamic> toJson() => _$DailyDrinkModelToJson(this);

  DailyDrinkModel copyWith({
    String? id,
    String? userId,
    String? name,
    int? calories,
    String? type,
    DateTime? timestamp,
    Map<String, dynamic>? nutritionFacts,
    String? notes,
  }) {
    return DailyDrinkModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      nutritionFacts: nutritionFacts ?? this.nutritionFacts,
      notes: notes ?? this.notes,
    );
  }
}
