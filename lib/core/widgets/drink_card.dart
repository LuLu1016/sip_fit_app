import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/widgets/elegant_icon.dart';

class DrinkCard extends StatelessWidget {
  final String name;
  final String type;

  const DrinkCard({
    super.key,
    required this.name,
    required this.type,
  });

  String _getDrinkType(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('garden') || lowerName.contains('herbal') || lowerName.contains('mint')) {
      return 'botanical';
    } else if (lowerName.contains('fizz') || lowerName.contains('spritz')) {
      return 'fruity';
    } else if (lowerName.contains('lavender') || lowerName.contains('rose')) {
      return 'floral';
    } else if (lowerName.contains('ginger') || lowerName.contains('spice')) {
      return 'spicy';
    } else if (lowerName.contains('latte') || lowerName.contains('smoothie')) {
      return 'creamy';
    } else if (lowerName.contains('citrus') || lowerName.contains('lemon')) {
      return 'citrus';
    } else {
      return 'herbal';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryPurple.withOpacity(0.05),
                    AppColors.primaryPink.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElegantIcon(
                    type: _getDrinkType(name),
                    size: 32,
                  ),
                  const Spacer(),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}