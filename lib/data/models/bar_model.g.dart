// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarModel _$BarModelFromJson(Map<String, dynamic> json) => BarModel(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  address: json['address'] as String,
  distance: (json['distance'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
  specialty: json['specialty'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  redeemableItems: (json['redeemableItems'] as List<dynamic>)
      .map((e) => RedeemableItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BarModelToJson(BarModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'address': instance.address,
  'distance': instance.distance,
  'rating': instance.rating,
  'specialty': instance.specialty,
  'tags': instance.tags,
  'description': instance.description,
  'redeemableItems': instance.redeemableItems,
};

RedeemableItem _$RedeemableItemFromJson(Map<String, dynamic> json) =>
    RedeemableItem(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      pointsRequired: (json['pointsRequired'] as num).toInt(),
      imageEmoji: json['imageEmoji'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RedeemableItemToJson(RedeemableItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'pointsRequired': instance.pointsRequired,
      'imageEmoji': instance.imageEmoji,
      'tags': instance.tags,
      'details': instance.details,
    };
