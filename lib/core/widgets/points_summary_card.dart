import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/presentation/providers/health_provider.dart';

class PointsSummaryCard extends ConsumerWidget {
  const PointsSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPointsAsync = ref.watch(totalPointsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Total Points',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textLight,
                  ),
            ),
            const SizedBox(height: 8),
            totalPointsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
              data: (points) => Text(
                points.toString(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ref.refresh(healthProvider);
                ref.refresh(totalPointsProvider);
              },
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text('Sync Health Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
