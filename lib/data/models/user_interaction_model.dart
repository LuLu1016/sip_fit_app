import 'package:json_annotation/json_annotation.dart';

part 'user_interaction_model.g.dart';

@JsonSerializable()
class UserInteraction {
  final String id;
  final String userId;
  final String message;
  final String agentResponse;
  final InteractionContext context;
  final DateTime timestamp;
  final List<String> recommendations;
  final UserMood mood;
  final List<String> tags;

  UserInteraction({
    required this.id,
    required this.userId,
    required this.message,
    required this.agentResponse,
    required this.context,
    required this.timestamp,
    required this.recommendations,
    required this.mood,
    required this.tags,
  });

  factory UserInteraction.fromJson(Map<String, dynamic> json) =>
      _$UserInteractionFromJson(json);
  Map<String, dynamic> toJson() => _$UserInteractionToJson(this);
}

@JsonSerializable()
class InteractionContext {
  final double currentCalories;
  final double remainingDrinkAllowance;
  final List<String> recentWorkouts;
  final TimeOfDay timeOfDay;
  final String location;
  final WeatherCondition weather;
  final UserStressLevel stressLevel;

  InteractionContext({
    required this.currentCalories,
    required this.remainingDrinkAllowance,
    required this.recentWorkouts,
    required this.timeOfDay,
    required this.location,
    required this.weather,
    required this.stressLevel,
  });

  factory InteractionContext.fromJson(Map<String, dynamic> json) =>
      _$InteractionContextFromJson(json);
  Map<String, dynamic> toJson() => _$InteractionContextToJson(this);
}

enum UserMood {
  happy,
  tired,
  stressed,
  energetic,
  relaxed,
  social,
  focused,
}

enum WeatherCondition {
  sunny,
  rainy,
  cloudy,
  hot,
  cold,
  moderate,
}

enum UserStressLevel {
  low,
  moderate,
  high,
}

enum TimeOfDay {
  morning,
  afternoon,
  evening,
  night,
}
