import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/cocktail_model.dart';
import 'package:sip_fit/data/models/fitness_drink_preferences_model.dart';
import 'package:sip_fit/data/models/user_profile_model.dart';

class DailyDrinksNotifier extends StateNotifier<AsyncValue<List<CocktailModel>>> {
  DailyDrinksNotifier() : super(const AsyncValue.data([]));

  // 记录今天喝过的饮品
  Future<void> logDrink(CocktailModel drink) async {
    state.whenData((drinks) {
      state = AsyncValue.data([...drinks, drink]);
    });
  }

  // 获取基于用户偏好的鸡尾酒推荐
  List<CocktailModel> getRecommendations(
    UserProfileModel userProfile,
    FitnessDrinkPreferencesModel preferences,
  ) {
    // 这里是示例推荐，实际应用中应该基于更复杂的推荐算法
    return [
      CocktailModel(
        id: 'healthy_mojito',
        name: 'Healthy Mojito',
        description: 'A refreshing low-calorie mojito with fresh mint and lime',
        ingredients: ['Fresh mint', 'Lime juice', 'Stevia', 'Sparkling water', 'White rum (optional)'],
        tags: ['Refreshing', 'Low-cal', 'Minty'],
        calories: 65,
        imageEmoji: '🍹',
        isAlcoholic: true,
        nutritionFacts: {
          'sugar': 2.5,
          'carbs': 4.0,
        },
        alcoholContent: 5.0,
      ),
      CocktailModel(
        id: 'berry_blast',
        name: 'Berry Blast Protein Cocktail',
        description: 'A protein-packed berry smoothie with a kick',
        ingredients: ['Mixed berries', 'Whey protein', 'Coconut water', 'Vodka (optional)'],
        tags: ['High-protein', 'Fruity', 'Post-workout'],
        calories: 120,
        imageEmoji: '🫐',
        isAlcoholic: true,
        nutritionFacts: {
          'protein': 15.0,
          'sugar': 8.0,
          'carbs': 12.0,
        },
        alcoholContent: 4.0,
      ),
      CocktailModel(
        id: 'green_goddess',
        name: 'Green Goddess',
        description: 'A nutrient-rich green cocktail with a gin base',
        ingredients: ['Cucumber', 'Green apple', 'Mint', 'Lime', 'Gin'],
        tags: ['Detox', 'Fresh', 'Low-sugar'],
        calories: 95,
        imageEmoji: '🥒',
        isAlcoholic: true,
        nutritionFacts: {
          'fiber': 3.0,
          'sugar': 4.0,
          'carbs': 6.0,
        },
        alcoholContent: 6.0,
      ),
      CocktailModel(
        id: 'tropical_dream',
        name: 'Tropical Dream',
        description: 'A tropical paradise in a glass with coconut water base',
        ingredients: ['Coconut water', 'Pineapple', 'Mango', 'White rum'],
        tags: ['Tropical', 'Hydrating', 'Vitamin-rich'],
        calories: 110,
        imageEmoji: '🥥',
        isAlcoholic: true,
        nutritionFacts: {
          'potassium': 250.0,
          'sugar': 10.0,
          'carbs': 15.0,
        },
        alcoholContent: 5.5,
      ),
    ];
  }

  // 获取无酒精版本的推荐
  List<CocktailModel> getMocktailRecommendations(
    UserProfileModel userProfile,
    FitnessDrinkPreferencesModel preferences,
  ) {
    final alcoholicDrinks = getRecommendations(userProfile, preferences);
    return alcoholicDrinks.map((drink) {
      return drink.copyWith(
        id: 'mocktail_${drink.id}',
        name: 'Virgin ${drink.name}',
        isAlcoholic: false,
        alcoholContent: 0.0,
        calories: (drink.calories * 0.7).round(), // 无酒精版本通常卡路里更低
      );
    }).toList();
  }
}

final dailyDrinksProvider = StateNotifierProvider<DailyDrinksNotifier, AsyncValue<List<CocktailModel>>>(
  (ref) => DailyDrinksNotifier(),
);
