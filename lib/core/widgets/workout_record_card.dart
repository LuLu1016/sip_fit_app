import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';

class WorkoutRecordCard extends StatelessWidget {
  final String type;
  final String duration;
  final int calories;
  final int points;
  final DateTime time;

  const WorkoutRecordCard({
    super.key,
    required this.type,
    required this.duration,
    required this.calories,
    required this.points,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.blueToIndigoGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              AppIcons.dumbbell,
              color: AppColors.textWhite,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      AppIcons.clock,
                      color: AppColors.textLight,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      AppIcons.flame,
                      color: AppColors.textLight,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$calories cal',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  AppIcons.gift,
                  color: AppColors.primaryPurple,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '+$points pts',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
