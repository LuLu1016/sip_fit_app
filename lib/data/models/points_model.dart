import 'package:json_annotation/json_annotation.dart';

part 'points_model.g.dart';

@JsonSerializable()
class PointsModel {
  final String id;
  final int pointsEarned;
  final DateTime date;
  final String activityType;

  PointsModel({
    required this.id,
    required this.pointsEarned,
    required this.date,
    required this.activityType,
  });

  factory PointsModel.fromJson(Map<String, dynamic> json) => _$PointsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointsModelToJson(this);
}
