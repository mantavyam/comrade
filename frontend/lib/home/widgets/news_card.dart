import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../news/domain/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;

  const NewsCard({
    super.key,
    required this.news,
    this.onTap,
    this.onBookmarkTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: KSizes.margin2x,
          vertical: KSizes.margin1x,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KSizes.radiusXL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: KSizes.elevationLarge,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(KSizes.radiusXL),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.network(
                  news.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: KColors.backgroundCard,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: KSizes.iconXXL,
                        color: KColors.textSecondary,
                      ),
                    );
                  },
                ),
              ),
              
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Content
              Positioned(
                left: KSizes.padding6x,
                right: KSizes.padding6x,
                bottom: KSizes.padding6x,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KSizes.padding3x,
                        vertical: KSizes.padding1x,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(news.category),
                        borderRadius: BorderRadius.circular(KSizes.radiusS),
                      ),
                      child: Text(
                        news.category.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: KSizes.fontSizeXS,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: KSizes.margin3x),
                    
                    // Title
                    Text(
                      news.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: KSizes.fontSizeXL,
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
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: KSizes.fontSizeM,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: KSizes.margin4x),
                    
                    // Meta Information
                    Row(
                      children: [
                        // Source
                        Expanded(
                          child: Text(
                            news.source,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: KSizes.fontSizeS,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        
                        // Read Time
                        Text(
                          '${news.readTime} min read',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: KSizes.fontSizeS,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Top Actions
              Positioned(
                top: KSizes.padding4x,
                right: KSizes.padding4x,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onBookmarkTap != null)
                      _buildActionButton(
                        icon: news.isBookmarked 
                            ? Icons.bookmark 
                            : Icons.bookmark_outline,
                        onTap: onBookmarkTap!,
                      ),
                    
                    const SizedBox(width: KSizes.margin2x),
                    
                    if (onShareTap != null)
                      _buildActionButton(
                        icon: Icons.share,
                        onTap: onShareTap!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: KSizes.iconXL,
        height: KSizes.iconXL,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: KSizes.iconM,
        ),
      ),
    );
  }

  Color _getCategoryColor(NewsCategory category) {
    switch (category) {
      case NewsCategory.defense:
        return KColors.primary;
      case NewsCategory.politics:
        return KColors.secondary;
      case NewsCategory.international:
        return KColors.info;
      case NewsCategory.economy:
        return KColors.success;
      case NewsCategory.technology:
        return KColors.warning;
      case NewsCategory.sports:
        return KColors.error;
      default:
        return KColors.textSecondary;
    }
  }
}
