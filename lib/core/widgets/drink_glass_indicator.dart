import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';

class DrinkGlassIndicator extends StatelessWidget {
  final double consumed;
  final double total;
  final String label;
  final String unit;

  const DrinkGlassIndicator({
    super.key,
    required this.consumed,
    required this.total,
    required this.label,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / total).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          height: 100,
          child: Stack(
            children: [
              // Glass outline
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.textMedium,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              // Liquid
              Positioned(
                bottom: 2,
                left: 2,
                right: 2,
                child: Container(
                  height: 76 * progress,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.purpleToPinkGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(38),
                      bottomRight: Radius.circular(38),
                    ),
                  ),
                ),
              ),
              // Glass stem
              Positioned(
                bottom: 0,
                left: 38,
                child: Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Glass base
              Positioned(
                bottom: 0,
                left: 33,
                child: Container(
                  width: 14,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${(total - consumed).toInt()}',
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
