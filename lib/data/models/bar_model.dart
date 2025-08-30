import 'package:json_annotation/json_annotation.dart';

part 'bar_model.g.dart';

@JsonSerializable()
class BarModel {
  final String id;
  final String name;
  final String imageUrl;
  final String address;
  final double distance;
  final double rating;
  final String specialty;
  final List<String> tags;
  final String description;
  final List<RedeemableItem> redeemableItems;

  BarModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.distance,
    required this.rating,
    required this.specialty,
    required this.tags,
    required this.description,
    required this.redeemableItems,
  });

  factory BarModel.fromJson(Map<String, dynamic> json) => _$BarModelFromJson(json);
  Map<String, dynamic> toJson() => _$BarModelToJson(this);
}

@JsonSerializable()
class RedeemableItem {
  final String id;
  final String name;
  final String type; // 'drink', 'appetizer', 'experience'
  final String description;
  final int pointsRequired;
  final String imageEmoji;
  final List<String> tags;
  final Map<String, dynamic>? details;

  RedeemableItem({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.pointsRequired,
    required this.imageEmoji,
    required this.tags,
    this.details,
  });

  factory RedeemableItem.fromJson(Map<String, dynamic> json) => _$RedeemableItemFromJson(json);
  Map<String, dynamic> toJson() => _$RedeemableItemToJson(this);
}
