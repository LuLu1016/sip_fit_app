import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/reward_model.dart';
import 'package:sip_fit/data/models/redemption_model.dart';

final rewardsProvider = FutureProvider<List<RewardModel>>((ref) async {
  // Mock rewards data
  await Future.delayed(const Duration(seconds: 1));
  
  return [
    RewardModel(
      rewardId: '1',
      partnerBarName: 'The Green Bar',
      couponDetails: '10% off any drink',
      drinkName: 'Any Drink',
      drinkImageUrl: 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=150',
      requiredPoints: 500,
    ),
    RewardModel(
      rewardId: '2',
      partnerBarName: 'Purple Lounge',
      couponDetails: 'Free Custom Cocktail',
      drinkName: 'Signature Mix',
      drinkImageUrl: 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=150',
      requiredPoints: 1000,
    ),
    RewardModel(
      rewardId: '3',
      partnerBarName: 'Fit Sip Corner',
      couponDetails: 'Buy One Get One Free',
      drinkName: 'Healthy Smoothie',
      drinkImageUrl: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=150',
      requiredPoints: 750,
    ),
    RewardModel(
      rewardId: '4',
      partnerBarName: 'Balance Brews',
      couponDetails: '20% off entire order',
      drinkName: 'Craft Beer Flight',
      drinkImageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=150',
      requiredPoints: 1500,
    ),
  ];
});

final redemptionProvider = StateNotifierProvider<RedemptionNotifier, AsyncValue<List<RedemptionModel>>>((ref) {
  return RedemptionNotifier();
});

class RedemptionNotifier extends StateNotifier<AsyncValue<List<RedemptionModel>>> {
  RedemptionNotifier() : super(const AsyncValue.data([]));

  Future<void> redeemReward(String rewardId, int requiredPoints) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    
    // Generate a mock redemption with QR code data
    final newRedemption = RedemptionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current-user-id',
      rewardId: rewardId,
      status: RedemptionStatus.active,
      redemptionDate: DateTime.now(),
      qrCodeData: 'FIT_SIP_${DateTime.now().millisecondsSinceEpoch}_$rewardId',
    );

    state = AsyncValue.data([...state.value ?? [], newRedemption]);
  }
}
