import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:sip_fit/core/widgets/elegant_icon.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class BarDetailPage extends ConsumerWidget {
  final Map<String, dynamic> bar;

  const BarDetailPage({
    super.key,
    required this.bar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coupons = [
      {
        'title': bar['signature'],
        'description': 'Signature cocktail + appetizer combo',
        'points': bar['points'],
        'validUntil': DateTime.now().add(const Duration(days: 30)),
        'isAvailable': true,
      },
      {
        'title': 'Happy Hour Special',
        'description': 'Buy one get one free on selected drinks',
        'points': (bar['points'] * 0.8).round(),
        'validUntil': DateTime.now().add(const Duration(days: 30)),
        'isAvailable': true,
      },
      {
        'title': 'VIP Experience',
        'description': 'Reserved seating + premium tasting menu',
        'points': bar['points'] * 2,
        'validUntil': DateTime.now().add(const Duration(days: 30)),
        'isAvailable': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBarInfo(context),
                    const SizedBox(height: 32),
                    Text(
                      'Available Rewards',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ...coupons.map((coupon) => _buildCouponCard(context, coupon)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.backgroundLight,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: bar['name'] == 'Sage'
                  ? [
                      const Color(0xFF8BC34A).withOpacity(0.3),
                      const Color(0xFF4CAF50).withOpacity(0.3),
                    ]
                  : bar['name'] == 'Cloud 9'
                      ? [
                          const Color(0xFF90CAF9).withOpacity(0.3),
                          const Color(0xFF2196F3).withOpacity(0.3),
                        ]
                      : [
                          const Color(0xFFFFB74D).withOpacity(0.3),
                          const Color(0xFFFF9800).withOpacity(0.3),
                        ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _DecorationPainter(
                    color: bar['name'] == 'Sage'
                        ? const Color(0xFF4CAF50).withOpacity(0.1)
                        : bar['name'] == 'Cloud 9'
                            ? const Color(0xFF2196F3).withOpacity(0.1)
                            : const Color(0xFFFF9800).withOpacity(0.1),
                  ),
                ),
              ),
              Center(
                child: ElegantIcon(
                  type: bar['name'] == 'Sage'
                      ? 'bar_elegant'
                      : bar['name'] == 'Cloud 9'
                          ? 'bar_modern'
                          : 'bar_cozy',
                  size: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bar['name'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    AppIcons.star,
                    color: AppColors.successGreen,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    bar['rating'].toString(),
                    style: TextStyle(
                      color: AppColors.successGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          bar['description'],
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(
              AppIcons.mapPin,
              color: AppColors.textLight,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              bar['distance'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 16),
            Icon(
              AppIcons.wine,
              color: AppColors.textLight,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              bar['signature'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCouponCard(BuildContext context, Map<String, dynamic> coupon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: coupon['isAvailable']
                    ? AppColors.purpleToPinkGradient
                    : [Colors.grey.shade300, Colors.grey.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coupon['title'],
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Valid until ${_formatDate(coupon['validUntil'])}',
                      style: TextStyle(
                        color: AppColors.textWhite.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${coupon['points']} points',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon['description'],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: coupon['isAvailable']
                        ? () {
                            _showRedeemDialog(context, coupon);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: coupon['isAvailable']
                          ? AppColors.primaryPurple
                          : Colors.grey.shade300,
                      foregroundColor: AppColors.textWhite,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      coupon['isAvailable'] ? 'Redeem Now' : 'Not Available',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  void _showRedeemDialog(BuildContext context, Map<String, dynamic> coupon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem Reward'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to redeem:'),
            const SizedBox(height: 8),
            Text(
              coupon['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('for ${coupon['points']} points?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement reward redemption
              Navigator.pop(context);
              _showConfirmationDialog(context, coupon);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Map<String, dynamic> coupon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'You have successfully redeemed:\n${coupon['title']}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Show this screen to the staff to claim your reward.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}

class _DecorationPainter extends CustomPainter {
  final Color color;

  _DecorationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    
    const hexSize = 30.0;
    const rows = 6;
    const cols = 8;
    
    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final xOffset = col * hexSize * 1.5;
        final yOffset = row * hexSize * math.sqrt(3) + 
            (col % 2) * hexSize * math.sqrt(3) / 2;
        
        final hexPath = Path();
        for (var i = 0; i < 6; i++) {
          final angle = i * math.pi / 3;
          final point = Offset(
            xOffset + hexSize * math.cos(angle),
            yOffset + hexSize * math.sin(angle),
          );
          
          if (i == 0) {
            hexPath.moveTo(point.dx, point.dy);
          } else {
            hexPath.lineTo(point.dx, point.dy);
          }
        }
        hexPath.close();
        path.addPath(hexPath, Offset.zero);
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}