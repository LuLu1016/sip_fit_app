import 'package:json_annotation/json_annotation.dart';

part 'redemption_model.g.dart';

enum RedemptionStatus { active, used, expired }

@JsonSerializable()
class RedemptionModel {
  final String id;
  final String userId;
  final String rewardId;
  final RedemptionStatus status;
  final DateTime redemptionDate;
  final String qrCodeData;

  RedemptionModel({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.status,
    required this.redemptionDate,
    required this.qrCodeData,
  });

  factory RedemptionModel.fromJson(Map<String, dynamic> json) => _$RedemptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$RedemptionModelToJson(this);
}
