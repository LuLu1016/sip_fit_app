// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsModel _$PointsModelFromJson(Map<String, dynamic> json) => PointsModel(
  id: json['id'] as String,
  pointsEarned: (json['pointsEarned'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  activityType: json['activityType'] as String,
);

Map<String, dynamic> _$PointsModelToJson(PointsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pointsEarned': instance.pointsEarned,
      'date': instance.date.toIso8601String(),
      'activityType': instance.activityType,
    };
