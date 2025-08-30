import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyDrinkState {
  final double totalAllowance;
  final double consumed;
  final List<DrinkRecord> records;

  DailyDrinkState({
    required this.totalAllowance,
    required this.consumed,
    required this.records,
  });

  DailyDrinkState copyWith({
    double? totalAllowance,
    double? consumed,
    List<DrinkRecord>? records,
  }) {
    return DailyDrinkState(
      totalAllowance: totalAllowance ?? this.totalAllowance,
      consumed: consumed ?? this.consumed,
      records: records ?? this.records,
    );
  }
}

class DrinkRecord {
  final String name;
  final double volume;
  final double calories;
  final DateTime timestamp;

  DrinkRecord({
    required this.name,
    required this.volume,
    required this.calories,
    required this.timestamp,
  });
}

class DailyDrinkNotifier extends StateNotifier<DailyDrinkState> {
  DailyDrinkNotifier() : super(DailyDrinkState(
    totalAllowance: 850,
    consumed: 0,
    records: [],
  ));

  void addDrink(String input) {
    // 解析输入文本，例如："300ml mojito" 或 "一杯mojito（约250ml）"
    final RegExp volumePattern = RegExp(r'(\d+)\s*ml');
    final match = volumePattern.firstMatch(input.toLowerCase());
    
    if (match != null) {
      final volume = double.parse(match.group(1)!);
      final name = input.toLowerCase()
          .replaceAll(volumePattern, '')
          .replaceAll(RegExp(r'[^a-zA-Z\s]'), '')
          .trim();

      // 根据饮品名称估算卡路里
      final calories = _estimateCalories(name, volume);
      
      final record = DrinkRecord(
        name: name,
        volume: volume,
        calories: calories,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        consumed: state.consumed + calories,
        records: [...state.records, record],
      );
    }
  }

  double _estimateCalories(String drinkName, double volume) {
    // 每100ml的大致卡路里含量
    final caloriesPer100ml = {
      'mojito': 65,
      'margarita': 70,
      'gin': 60,
      'tonic': 35,
      'vodka': 55,
      'rum': 65,
      'whiskey': 70,
      'beer': 43,
      'wine': 83,
      'cocktail': 65,
      'mocktail': 45,
    };

    double baseCalories = 65; // 默认值
    for (final entry in caloriesPer100ml.entries) {
      if (drinkName.contains(entry.key)) {
        baseCalories = entry.value;
        break;
      }
    }

    return (baseCalories * volume / 100).roundToDouble();
  }

  void reset() {
    state = DailyDrinkState(
      totalAllowance: 850,
      consumed: 0,
      records: [],
    );
  }
}

final dailyDrinkProvider = StateNotifierProvider<DailyDrinkNotifier, DailyDrinkState>((ref) {
  return DailyDrinkNotifier();
});