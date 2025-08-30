// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailModel _$CocktailModelFromJson(Map<String, dynamic> json) =>
    CocktailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      calories: (json['calories'] as num).toInt(),
      imageEmoji: json['imageEmoji'] as String,
      isAlcoholic: json['isAlcoholic'] as bool,
      nutritionFacts: (json['nutritionFacts'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      alcoholContent: (json['alcoholContent'] as num?)?.toDouble(),
      specialNote: json['specialNote'] as String?,
    );

Map<String, dynamic> _$CocktailModelToJson(CocktailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'tags': instance.tags,
      'calories': instance.calories,
      'imageEmoji': instance.imageEmoji,
      'isAlcoholic': instance.isAlcoholic,
      'nutritionFacts': instance.nutritionFacts,
      'alcoholContent': instance.alcoholContent,
      'specialNote': instance.specialNote,
    };
