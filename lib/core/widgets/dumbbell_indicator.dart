import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';

class DumbbellIndicator extends StatelessWidget {
  final int calories;
  final String label;
  final String unit;

  const DumbbellIndicator({
    super.key,
    required this.calories,
    required this.label,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          height: 100,
          child: Stack(
            children: [
              // Dumbbell bar
              Positioned(
                top: 24,
                left: 4,
                right: 4,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.blueToIndigoGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // Left weight
              Positioned(
                top: 16,
                left: 0,
                child: Container(
                  width: 16,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.textMedium,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Right weight
              Positioned(
                top: 16,
                right: 0,
                child: Container(
                  width: 16,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.textMedium,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Glow effect
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryBlue.withOpacity(0.3),
                        AppColors.primaryPurple.withOpacity(0.0),
                      ],
                      center: Alignment.center,
                      radius: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          calories.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          '$label $unit',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
