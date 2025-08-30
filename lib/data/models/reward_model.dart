import 'package:json_annotation/json_annotation.dart';

part 'reward_model.g.dart';

@JsonSerializable()
class RewardModel {
  final String rewardId;
  final String partnerBarName;
  final String couponDetails;
  final String drinkName;
  final String? drinkImageUrl;
  final int requiredPoints;

  RewardModel({
    required this.rewardId,
    required this.partnerBarName,
    required this.couponDetails,
    required this.drinkName,
    this.drinkImageUrl,
    required this.requiredPoints,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) => _$RewardModelFromJson(json);
  Map<String, dynamic> toJson() => _$RewardModelToJson(this);
}
