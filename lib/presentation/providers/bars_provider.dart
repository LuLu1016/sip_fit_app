import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/bar_model.dart';

class BarsNotifier extends StateNotifier<AsyncValue<List<BarModel>>> {
  BarsNotifier() : super(AsyncValue.data(_mockBars));

  static final List<BarModel> _mockBars = [
    BarModel(
      id: '1',
      name: 'The Fitness Bar',
      imageUrl: 'assets/images/bar1.jpg',
      address: '123 Health Street',
      distance: 0.3,
      rating: 4.8,
      specialty: 'Protein-infused cocktails',
      tags: ['Healthy', 'Post-workout', 'Protein'],
      description: 'A unique bar that combines fitness and fun with protein-infused cocktails and healthy bar snacks.',
      redeemableItems: [
        RedeemableItem(
          id: '1',
          name: 'Protein Mojito',
          type: 'drink',
          description: '15g protein, fresh mint, lime juice, and rum',
          pointsRequired: 500,
          imageEmoji: '🍹',
          tags: ['Protein', 'Refreshing'],
        ),
        RedeemableItem(
          id: '2',
          name: 'Quinoa Bites',
          type: 'appetizer',
          description: 'Protein-rich quinoa bites with avocado dip',
          pointsRequired: 300,
          imageEmoji: '🥑',
          tags: ['Healthy', 'Protein'],
        ),
      ],
    ),
    BarModel(
      id: '2',
      name: 'Zen Garden Lounge',
      imageUrl: 'assets/images/bar2.jpg',
      address: '456 Wellness Ave',
      distance: 0.5,
      rating: 4.9,
      specialty: 'Low-calorie craft cocktails',
      tags: ['Zen', 'Low-cal', 'Organic'],
      description: 'A peaceful oasis offering mindfully crafted cocktails and healthy small plates.',
      redeemableItems: [
        RedeemableItem(
          id: '3',
          name: 'Zen Martini',
          type: 'drink',
          description: 'Green tea infused gin, cucumber, mint',
          pointsRequired: 450,
          imageEmoji: '🍸',
          tags: ['Low-cal', 'Refreshing'],
        ),
        RedeemableItem(
          id: '4',
          name: 'Private Mixology Class',
          type: 'experience',
          description: 'Learn to make healthy cocktails',
          pointsRequired: 1000,
          imageEmoji: '🎓',
          tags: ['Class', 'VIP'],
        ),
      ],
    ),
    BarModel(
      id: '3',
      name: 'Active Social Club',
      imageUrl: 'assets/images/bar3.jpg',
      address: '789 Fitness Blvd',
      distance: 0.8,
      rating: 4.7,
      specialty: 'Sports-themed healthy drinks',
      tags: ['Sports', 'Social', 'Active'],
      description: 'The perfect spot to socialize and stay healthy with sports-themed cocktails and activities.',
      redeemableItems: [
        RedeemableItem(
          id: '5',
          name: 'Marathon Mule',
          type: 'drink',
          description: 'Electrolyte-enhanced Moscow Mule',
          pointsRequired: 400,
          imageEmoji: '🏃',
          tags: ['Electrolytes', 'Energizing'],
        ),
        RedeemableItem(
          id: '6',
          name: 'Game Day Experience',
          type: 'experience',
          description: 'VIP sports viewing with healthy snacks',
          pointsRequired: 800,
          imageEmoji: '🎮',
          tags: ['VIP', 'Sports'],
        ),
      ],
    ),
  ];

  // Get all bars
  List<BarModel> getBars() {
    return state.value ?? [];
  }

  // Get bar by ID
  BarModel? getBarById(String id) {
    return state.value?.firstWhere((bar) => bar.id == id);
  }

  // Get redeemable items by bar ID
  List<RedeemableItem> getRedeemableItems(String barId) {
    return state.value
        ?.firstWhere((bar) => bar.id == barId)
        .redeemableItems ?? [];
  }
}

final barsProvider = StateNotifierProvider<BarsNotifier, AsyncValue<List<BarModel>>>(
  (ref) => BarsNotifier(),
);
