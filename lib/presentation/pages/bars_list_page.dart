import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:sip_fit/core/widgets/gradient_container.dart';
import 'package:sip_fit/core/widgets/elegant_icon.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class BarsListPage extends ConsumerWidget {
  const BarsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data - Replace with actual providers
    const totalPoints = 1250;
    final bars = [
      {
        'name': 'Sage',
        'description': 'Botanical cocktails & modern cuisine',
        'image': 'assets/images/sage.jpg',
        'rating': 4.8,
        'distance': '0.8 km',
        'signature': 'Botanical Garden',
        'points': 500,
      },
      {
        'name': 'Cloud 9',
        'description': 'Rooftop bar with city views',
        'image': 'assets/images/cloud9.jpg',
        'rating': 4.6,
        'distance': '1.2 km',
        'signature': 'Lavender Fizz',
        'points': 450,
      },
      {
        'name': 'The Nest',
        'description': 'Cozy speakeasy with craft cocktails',
        'image': 'assets/images/nest.jpg',
        'rating': 4.7,
        'distance': '1.5 km',
        'signature': 'Cucumber Gin Spritz',
        'points': 400,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, totalPoints),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPointsSummary(context, totalPoints),
                    const SizedBox(height: 24),
                    _buildBarsList(context, bars),
                  ],
                ),
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
      children: [
        Text(
          'Recommended Bars',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...bars.map((bar) => _buildBarCard(context, bar)),
      ],
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 600))
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildBarCard(BuildContext context, Map<String, dynamic> bar) {
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
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryPurple.withOpacity(0.1),
                  AppColors.primaryPink.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // 背景渐变
                Container(
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
                ),
                // 装饰图案
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
                // 中心图标
                Center(
                  child: ElegantIcon(
                    type: bar['name'] == 'Sage'
                        ? 'bar_elegant'
                        : bar['name'] == 'Cloud 9'
                            ? 'bar_modern'
                            : 'bar_cozy',
                    size: 80,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bar['name'],
                      style: Theme.of(context).textTheme.titleLarge,
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
                  style: Theme.of(context).textTheme.bodyMedium,
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
                      style: Theme.of(context).textTheme.bodySmall,
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
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${bar['points']} points',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to bar detail page
                      },
                      child: const Text('View Details'),
                    ),
                  ],
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