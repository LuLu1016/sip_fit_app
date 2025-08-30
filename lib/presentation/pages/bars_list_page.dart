import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:sip_fit/core/widgets/elegant_icon.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sip_fit/presentation/pages/bar_detail_page.dart';
import 'dart:math' as math;

class BarsListPage extends ConsumerWidget {
  const BarsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data - Replace with actual providers
    const totalPoints = 1250;
    final bars = [
      {
        'name': 'Neon Nights',
        'description': 'Modern cocktail lounge',
        'rating': 4.6,
        'distance': '0.7 miles',
        'signature': 'Recovery Spritz',
        'points': 600,
        'special': 'Happy hour special',
      },
      {
        'name': 'Craft & Kettlebells',
        'description': 'Fitness-focused gastropub',
        'rating': 4.9,
        'distance': '1.2 miles',
        'signature': 'Post-Workout IPA',
        'points': 500,
        'special': 'Free appetizer included',
      },
      {
        'name': 'The Rooftop',
        'description': 'Skyline views & craft cocktails',
        'rating': 4.7,
        'distance': '0.9 miles',
        'signature': 'Sunset Spritz',
        'points': 450,
        'special': 'Group discount available',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(context, totalPoints),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildPointsSummary(context, totalPoints),
                  const SizedBox(height: 24),
                  _buildBarsList(context, bars),
                  const SizedBox(height: 24),
                  _buildSquadGoals(context),
                  // Add extra padding at the bottom to ensure content is not covered by navigation bar
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int points) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.purpleToPinkGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  AppIcons.gift,
                  color: AppColors.textWhite,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Points',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    '$points points available',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement filter
            },
            icon: Icon(
              AppIcons.filter,
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildPointsSummary(BuildContext context, int points) {
    return GradientContainer(
      colors: AppColors.purpleToOrangeGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Points',
                    style: TextStyle(
                      color: AppColors.textWhite.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    points.toString(),
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.textWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  AppIcons.trophy,
                  color: AppColors.textWhite,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.textWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  AppIcons.info,
                  color: AppColors.textWhite,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Next reward at 1,500 points',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: -0.2, end: 0);
  }

  Widget _buildBarsList(BuildContext context, List<Map<String, dynamic>> bars) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Recommended Bars',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...bars.map((bar) => Padding(
          padding: EdgeInsets.only(bottom: bar == bars.last ? 0 : 16),
          child: _buildBarCard(context, bar),
        )),
      ],
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildBarCard(BuildContext context, Map<String, dynamic> bar) {
    return Container(
      margin: EdgeInsets.zero,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarDetailPage(bar: bar),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ElegantIcon(
                          type: bar['name'] == 'Sage'
                              ? 'bar_elegant'
                              : bar['name'] == 'Cloud 9'
                                  ? 'bar_modern'
                                  : 'bar_cozy',
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bar['name'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                AppIcons.mapPin,
                                color: AppColors.textLight,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                bar['distance'],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textLight,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                AppIcons.star,
                                color: AppColors.textLight,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                bar['rating'].toString(),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textLight,
                                ),
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${bar['points']} points',
                        style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.wine,
                        color: AppColors.textLight,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bar['signature'],
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              bar['special'],
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarDetailPage(bar: bar),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Redeem Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}

  Widget _buildSquadGoals(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFF3E0),
            const Color(0xFFFFE0B2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AppIcons.user,
                    color: const Color(0xFFFF9800),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Squad Goals',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFE65100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'Tonight',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFE65100),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Sarah, Mike & Alex earned group discount at The Rooftop!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFE65100),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement group reservation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Join Group Reservation'),
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .slideY(begin: 0.2, end: 0);
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

    // 绘制装饰性几何图案
    final path = Path();
    
    // 绘制六边形网格
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