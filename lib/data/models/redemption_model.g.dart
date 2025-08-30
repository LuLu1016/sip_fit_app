// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redemption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedemptionModel _$RedemptionModelFromJson(Map<String, dynamic> json) =>
    RedemptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      rewardId: json['rewardId'] as String,
      status: $enumDecode(_$RedemptionStatusEnumMap, json['status']),
      redemptionDate: DateTime.parse(json['redemptionDate'] as String),
      qrCodeData: json['qrCodeData'] as String,
    );

Map<String, dynamic> _$RedemptionModelToJson(RedemptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'rewardId': instance.rewardId,
      'status': _$RedemptionStatusEnumMap[instance.status]!,
      'redemptionDate': instance.redemptionDate.toIso8601String(),
      'qrCodeData': instance.qrCodeData,
    };

const _$RedemptionStatusEnumMap = {
  RedemptionStatus.active: 'active',
  RedemptionStatus.used: 'used',
  RedemptionStatus.expired: 'expired',
};
