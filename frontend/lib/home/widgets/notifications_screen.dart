import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: KColors.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(KSizes.padding4x),
        children: [
          _buildNotificationItem(
            context,
            icon: Icons.article,
            title: 'New Defense News Available',
            description: 'Check out the latest updates on Indian Army exercises',
            time: '2 hours ago',
            isUnread: true,
          ),
          _buildNotificationItem(
            context,
            icon: Icons.quiz,
            title: 'Daily Quiz Ready',
            description: 'Test your knowledge with today\'s current affairs quiz',
            time: '4 hours ago',
            isUnread: true,
          ),
          _buildNotificationItem(
            context,
            icon: Icons.bookmark,
            title: 'Bookmark Reminder',
            description: 'You have 5 unread bookmarked articles',
            time: '1 day ago',
            isUnread: false,
          ),
          _buildNotificationItem(
            context,
            icon: Icons.auto_stories,
            title: 'New Hero Story',
            description: 'Read about the courage of Captain Vikram Batra',
            time: '2 days ago',
            isUnread: false,
          ),
          _buildNotificationItem(
            context,
            icon: Icons.trending_up,
            title: 'Streak Achievement',
            description: 'Congratulations! You\'ve maintained a 7-day streak',
            time: '3 days ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: KSizes.margin3x),
      padding: const EdgeInsets.all(KSizes.padding4x),
      decoration: BoxDecoration(
        color: isUnread 
            ? KColors.primary.withValues(alpha: 0.05)
            : KColors.backgroundCard,
        borderRadius: BorderRadius.circular(KSizes.radiusM),
        border: Border.all(
          color: isUnread 
              ? KColors.primary.withValues(alpha: 0.2)
              : KColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: KSizes.iconXL,
            height: KSizes.iconXL,
            decoration: BoxDecoration(
              color: isUnread 
                  ? KColors.primary 
                  : KColors.textSecondary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isUnread ? Colors.white : KColors.textSecondary,
              size: KSizes.iconM,
            ),
          ),
          
          const SizedBox(width: KSizes.margin3x),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                          color: isUnread ? KColors.textPrimary : KColors.textSecondary,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: KColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: KSizes.margin1x),
                
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KColors.textSecondary,
                    height: 1.3,
                  ),
                ),
                
                const SizedBox(height: KSizes.margin2x),
                
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KColors.textSecondary,
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
