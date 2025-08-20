import 'package:flutter/material.dart';
import '../../../core/constants/k_colors.dart';
import '../../../core/constants/k_sizes.dart';
import '../../../news/domain/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onReadMoreTap;

  const NewsCard({
    super.key,
    required this.news,
    this.onBookmarkTap,
    this.onShareTap,
    this.onReadMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: KSizes.margin2x,
        vertical: KSizes.margin3x,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KSizes.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: KSizes.elevationMedium,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KSizes.radiusL),
        child: Stack(
          children: [
            // Background Image
            _buildBackgroundImage(),
            
            // Gradient Overlay
            _buildGradientOverlay(),
            
            // Content
            _buildContent(context),
            
            // Top Actions
            _buildTopActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: news.imageUrl.isNotEmpty
          ? Image.network(
              news.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholderImage();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildPlaceholderImage();
              },
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KColors.primary.withValues(alpha: 0.8),
            KColors.primaryDark,
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.article,
          size: KSizes.iconXXL,
          color: KColors.textOnPrimary,
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: KColors.overlayGradient,
            stops: [0.0, 0.7, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Positioned(
      left: KSizes.padding4x,
      right: KSizes.padding4x,
      bottom: KSizes.padding4x,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category and Read Time
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: KSizes.padding2x,
                  vertical: KSizes.padding1x,
                ),
                decoration: BoxDecoration(
                  color: KColors.primary,
                  borderRadius: BorderRadius.circular(KSizes.radiusS),
                ),
                child: Text(
                  news.category.displayName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: KSizes.margin2x),
              Text(
                '${news.readTime} min read',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: KColors.textOnPrimary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: KSizes.margin3x),
          
          // Title
          Text(
            news.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: KColors.textOnPrimary,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: KSizes.margin2x),
          
          // Description
          Text(
            news.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: KColors.textOnPrimary.withValues(alpha: 0.9),
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: KSizes.margin4x),
          
          // Source and Date
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.source,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: KColors.textOnPrimary.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (news.publishedAt != null) ...[
                      const SizedBox(height: KSizes.margin1x),
                      Text(
                        _formatDate(news.publishedAt!),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: KColors.textOnPrimary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Read More Button
              if (onReadMoreTap != null)
                TextButton(
                  onPressed: onReadMoreTap,
                  style: TextButton.styleFrom(
                    backgroundColor: KColors.textOnPrimary.withValues(alpha: 0.2),
                    foregroundColor: KColors.textOnPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: KSizes.padding3x,
                      vertical: KSizes.padding2x,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(KSizes.radiusM),
                    ),
                  ),
                  child: const Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: KSizes.fontSizeS,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopActions() {
    return Positioned(
      top: KSizes.padding4x,
      right: KSizes.padding4x,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bookmark Button
          if (onBookmarkTap != null)
            _buildActionButton(
              icon: news.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              onTap: onBookmarkTap!,
              isActive: news.isBookmarked,
            ),
          
          const SizedBox(width: KSizes.margin2x),
          
          // Share Button
          if (onShareTap != null)
            _buildActionButton(
              icon: Icons.share,
              onTap: onShareTap!,
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: KSizes.iconXL,
        height: KSizes.iconXL,
        decoration: BoxDecoration(
          color: isActive 
              ? KColors.primary 
              : KColors.textOnPrimary.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: isActive 
              ? null 
              : Border.all(
                  color: KColors.textOnPrimary.withValues(alpha: 0.3),
                  width: 1,
                ),
        ),
        child: Icon(
          icon,
          size: KSizes.iconM,
          color: isActive 
              ? KColors.textOnPrimary 
              : KColors.textOnPrimary.withValues(alpha: 0.9),
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
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
