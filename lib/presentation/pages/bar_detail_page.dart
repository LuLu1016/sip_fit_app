import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/core/constants/app_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BarDetailPage extends ConsumerWidget {
  final Map<String, dynamic> bar;

  const BarDetailPage({
    super.key,
    required this.bar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final redeemableItems = [
      {
        'name': bar['signature'],
        'description': 'Signature cocktail crafted with premium spirits',
        'points': 400,
        'type': 'drink',
      },
      {
        'name': 'Appetizer Platter',
        'description': 'Chef\'s selection of seasonal appetizers',
        'points': 300,
        'type': 'food',
      },
      {
        'name': 'VIP Experience',
        'description': 'Priority seating and personalized service',
        'points': 600,
        'type': 'experience',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // 顶部图片和返回按钮
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    bar['image'],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // 内容
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 酒吧信息
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bar['name'],
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 8),
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
                            ],
                          ),
                        ],
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
                  const SizedBox(height: 24),
                  // 描述
                  Text(
                    bar['description'],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  // 可兑换项目
                  Text(
                    'Redeemable Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...redeemableItems.map((item) => _buildRedeemableItem(context, item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemableItem(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              color: AppColors.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getItemIcon(item['type']),
              color: AppColors.primaryPurple,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${item['points']} pts',
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  _showRedeemDialog(context, item);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  backgroundColor: AppColors.primaryPurple.withOpacity(0.1),
                ),
                child: Text(
                  'Redeem',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .slideX(begin: 0.2, end: 0);
  }

  IconData _getItemIcon(String type) {
    switch (type) {
      case 'drink':
        return AppIcons.wine;
      case 'food':
        return Icons.restaurant;
      case 'experience':
        return Icons.star;
      default:
        return Icons.redeem;
    }
  }

  void _showRedeemDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Redeem ${item['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to redeem this item for ${item['points']} points?'),
            const SizedBox(height: 16),
            Text(
              'Show this screen to the staff to claim your reward.',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement redemption logic
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}