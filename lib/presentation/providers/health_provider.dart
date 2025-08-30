import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/data/models/points_model.dart';

final healthProvider = FutureProvider<List<PointsModel>>((ref) async {
  // Mock data - this will be replaced with real HealthKit data later
  await Future.delayed(const Duration(seconds: 1));
  
  return [
    PointsModel(
      id: '1',
      pointsEarned: 250,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      activityType: 'Running',
    ),
    PointsModel(
      id: '2',
      pointsEarned: 120,
      date: DateTime.now().subtract(const Duration(days: 1)),
      activityType: 'Walking',
    ),
    PointsModel(
      id: '3',
      pointsEarned: 180,
      date: DateTime.now().subtract(const Duration(days: 2)),
      activityType: 'Cycling',
    ),
    PointsModel(
      id: '4',
      pointsEarned: 300,
      date: DateTime.now().subtract(const Duration(days: 3)),
      activityType: 'Swimming',
    ),
  ];
});

final totalPointsProvider = FutureProvider<int>((ref) async {
  final pointsAsync = ref.watch(healthProvider);
  return pointsAsync.when(
    data: (points) {
      int total = 0;
      for (final point in points) {
        total += point.pointsEarned;
      }
      return total;
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
});
