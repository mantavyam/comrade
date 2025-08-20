import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String description;
  final int questionsCount;
  final int timeLimit;
  final VoidCallback onTap;

  const QuizCard({
    super.key,
    required this.title,
    required this.description,
    required this.questionsCount,
    required this.timeLimit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(KSizes.padding6x),
        decoration: BoxDecoration(
          color: KColors.backgroundCard,
          borderRadius: BorderRadius.circular(KSizes.radiusXL),
          border: Border.all(color: KColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: KSizes.elevationMedium,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Icon
            Row(
              children: [
                Container(
                  width: KSizes.iconXL,
                  height: KSizes.iconXL,
                  decoration: BoxDecoration(
                    color: KColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.quiz,
                    color: Colors.white,
                    size: KSizes.iconM,
                  ),
                ),
                
                const SizedBox(width: KSizes.margin3x),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: KSizes.margin1x),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: KSizes.margin6x),
            
            // Quiz Stats
            Row(
              children: [
                _buildStatItem(
                  context,
                  icon: Icons.quiz_outlined,
                  label: 'Questions',
                  value: questionsCount.toString(),
                ),
                
                const SizedBox(width: KSizes.margin6x),
                
                _buildStatItem(
                  context,
                  icon: Icons.timer_outlined,
                  label: 'Time Limit',
                  value: '${timeLimit}m',
                ),
              ],
            ),
            
            const SizedBox(height: KSizes.margin6x),
            
            // Start Quiz Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Quiz'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: KSizes.padding4x,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: KSizes.iconS,
          color: KColors.textSecondary,
        ),
        const SizedBox(width: KSizes.margin1x),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: KColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
