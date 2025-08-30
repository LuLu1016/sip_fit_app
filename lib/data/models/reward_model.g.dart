// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardModel _$RewardModelFromJson(Map<String, dynamic> json) => RewardModel(
  rewardId: json['rewardId'] as String,
  partnerBarName: json['partnerBarName'] as String,
  couponDetails: json['couponDetails'] as String,
  drinkName: json['drinkName'] as String,
  drinkImageUrl: json['drinkImageUrl'] as String?,
  requiredPoints: (json['requiredPoints'] as num).toInt(),
);

Map<String, dynamic> _$RewardModelToJson(RewardModel instance) =>
    <String, dynamic>{
      'rewardId': instance.rewardId,
      'partnerBarName': instance.partnerBarName,
      'couponDetails': instance.couponDetails,
      'drinkName': instance.drinkName,
      'drinkImageUrl': instance.drinkImageUrl,
      'requiredPoints': instance.requiredPoints,
    };
