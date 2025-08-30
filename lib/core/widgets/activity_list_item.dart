import 'package:flutter/material.dart';
import 'package:sip_fit/core/constants/app_colors.dart';
import 'package:sip_fit/data/models/points_model.dart';

class ActivityListItem extends StatelessWidget {
  final PointsModel activity;

  const ActivityListItem({super.key, required this.activity});

  IconData _getActivityIcon(String type) {
    switch (type.toLowerCase()) {
      case 'running':
        return Icons.directions_run;
      case 'walking':
        return Icons.directions_walk;
      case 'cycling':
        return Icons.directions_bike;
      case 'swimming':
        return Icons.pool;
      default:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryGreen.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getActivityIcon(activity.activityType),
          color: AppColors.accentGreen,
        ),
      ),
      title: Text(
        activity.activityType,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${activity.pointsEarned} points • ${_formatDate(activity.date)}',
        style: TextStyle(color: AppColors.textLight),
      ),
      trailing: Text(
        '+${activity.pointsEarned}',
        style: TextStyle(
          color: AppColors.accentPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
