import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../news/domain/news_model.dart';

class ExpandedNewsDetail extends StatelessWidget {
  final NewsModel news;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;

  const ExpandedNewsDetail({
    super.key,
    required this.news,
    this.onBookmarkTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: KColors.background,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              if (onBookmarkTap != null)
                IconButton(
                  onPressed: onBookmarkTap,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      news.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (onShareTap != null)
                IconButton(
                  onPressed: onShareTap,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
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
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(KSizes.padding6x),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Title
                  Text(
                    news.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin3x),
                  
                  // Meta Information
                  Row(
                    children: [
                      // Author
                      if (news.author.isNotEmpty) ...[
                        Text(
                          'By ${news.author}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: KColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: KSizes.margin2x),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: KColors.textSecondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: KSizes.margin2x),
                      ],
                      
                      // Source
                      Text(
                        news.source,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Read Time
                      Text(
                        '${news.readTime} min read',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: KSizes.margin2x),
                  
                  // Published Date
                  Text(
                    _formatDate(news.publishedAt ?? DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: KColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Description
                  Text(
                    news.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Content
                  Text(
                    news.content,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin8x),
                  
                  // Tags
                  if (news.tags.isNotEmpty) ...[
                    Text(
                      'Tags',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: KSizes.margin3x),
                    Wrap(
                      spacing: KSizes.margin2x,
                      runSpacing: KSizes.margin2x,
                      children: news.tags.map((tag) => _buildTag(tag)).toList(),
                    ),
                    const SizedBox(height: KSizes.margin8x),
                  ],
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onBookmarkTap,
                          icon: Icon(
                            news.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                          ),
                          label: Text(
                            news.isBookmarked ? 'Bookmarked' : 'Bookmark',
                          ),
                        ),
                      ),
                      const SizedBox(width: KSizes.margin3x),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onShareTap,
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: KSizes.margin8x),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.padding3x,
        vertical: KSizes.padding1x,
      ),
      decoration: BoxDecoration(
        color: KColors.backgroundCard,
        borderRadius: BorderRadius.circular(KSizes.radiusM),
        border: Border.all(color: KColors.border),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: KSizes.fontSizeS,
          color: KColors.textSecondary,
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
