import 'package:json_annotation/json_annotation.dart';

part 'cocktail_model.g.dart';

@JsonSerializable()
class CocktailModel {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> tags;
  final int calories;
  final String imageEmoji;
  final bool isAlcoholic;
  final Map<String, double> nutritionFacts;
  final double? alcoholContent;
  final String? specialNote;

  CocktailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.tags,
    required this.calories,
    required this.imageEmoji,
    required this.isAlcoholic,
    required this.nutritionFacts,
    this.alcoholContent,
    this.specialNote,
  });

  factory CocktailModel.fromJson(Map<String, dynamic> json) => _$CocktailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CocktailModelToJson(this);

  CocktailModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? ingredients,
    List<String>? tags,
    int? calories,
    String? imageEmoji,
    bool? isAlcoholic,
    Map<String, double>? nutritionFacts,
    double? alcoholContent,
    String? specialNote,
  }) {
    return CocktailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      tags: tags ?? this.tags,
      calories: calories ?? this.calories,
      imageEmoji: imageEmoji ?? this.imageEmoji,
      isAlcoholic: isAlcoholic ?? this.isAlcoholic,
      nutritionFacts: nutritionFacts ?? this.nutritionFacts,
      alcoholContent: alcoholContent ?? this.alcoholContent,
      specialNote: specialNote ?? this.specialNote,
    );
  }
}
