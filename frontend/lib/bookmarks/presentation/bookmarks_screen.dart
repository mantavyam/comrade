import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../news/domain/news_model.dart';
import '../../home/widgets/expanded_news_detail.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  // Mock bookmarked news data
  final List<NewsModel> _bookmarkedNews = [
    NewsModel(
      id: '1',
      title: 'Indian Army Conducts Major Exercise Along LAC',
      description: 'The Indian Army conducted a comprehensive military exercise along the Line of Actual Control to test readiness and coordination.',
      content: 'In a significant display of military preparedness, the Indian Army conducted a major exercise along the Line of Actual Control (LAC) involving multiple divisions and advanced weaponry systems...',
      imageUrl: 'https://via.placeholder.com/400x280/2E7D32/FFFFFF?text=Defense+News',
      source: 'Press Information Bureau',
      author: 'Defense Correspondent',
      category: NewsCategory.defense,
      tags: ['Army', 'LAC', 'Exercise', 'Defense'],
      readTime: 3,
      publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      isBookmarked: true,
    ),
    NewsModel(
      id: '2',
      title: 'New Defense Technology Initiative Launched',
      description: 'Government announces new initiative to boost indigenous defense technology development and reduce import dependency.',
      content: 'The Ministry of Defense today announced a groundbreaking initiative aimed at accelerating indigenous defense technology development...',
      imageUrl: 'https://via.placeholder.com/400x280/FF9800/FFFFFF?text=Technology',
      source: 'The Hindu',
      author: 'Tech Reporter',
      category: NewsCategory.technology,
      tags: ['Technology', 'Defense', 'Innovation', 'Make in India'],
      readTime: 4,
      publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
      isBookmarked: true,
    ),
    NewsModel(
      id: '3',
      title: 'International Military Cooperation Summit',
      description: 'India hosts international summit on military cooperation and peacekeeping operations with allied nations.',
      content: 'New Delhi hosted a significant international summit focusing on military cooperation and joint peacekeeping operations...',
      imageUrl: 'https://via.placeholder.com/400x280/2196F3/FFFFFF?text=International',
      source: 'Indian Express',
      author: 'International Desk',
      category: NewsCategory.international,
      tags: ['International', 'Cooperation', 'Summit', 'Peacekeeping'],
      readTime: 5,
      publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
      isBookmarked: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(KSizes.padding6x),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bookmarks',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: KSizes.margin1x),
                        Text(
                          '${_bookmarkedNews.length} saved articles',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: KColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Clear All Button
                  if (_bookmarkedNews.isNotEmpty)
                    TextButton(
                      onPressed: _showClearAllDialog,
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: KColors.error),
                      ),
                    ),
                ],
              ),
            ),
            
            // Bookmarked Articles List
            Expanded(
              child: _bookmarkedNews.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: KSizes.padding4x),
                      itemCount: _bookmarkedNews.length,
                      itemBuilder: (context, index) {
                        return _buildBookmarkCard(context, _bookmarkedNews[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_outline,
            size: KSizes.iconXXL,
            color: KColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: KSizes.margin4x),
          Text(
            'No Bookmarks Yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: KColors.textSecondary,
            ),
          ),
          const SizedBox(height: KSizes.margin2x),
          Text(
            'Start bookmarking articles to read them later',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: KColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkCard(BuildContext context, NewsModel news, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: KSizes.margin4x),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ExpandedNewsDetail(
                news: news,
                onBookmarkTap: () => _removeBookmark(index),
                onShareTap: () => _shareNews(news),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: KColors.backgroundCard,
            borderRadius: BorderRadius.circular(KSizes.radiusL),
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
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(KSizes.radiusL),
                  topRight: Radius.circular(KSizes.radiusL),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image.network(
                        news.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: KColors.primary.withValues(alpha: 0.1),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: KSizes.iconXL,
                              color: KColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Category Badge
                    Positioned(
                      top: KSizes.padding3x,
                      left: KSizes.padding3x,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: KSizes.padding2x,
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
                    ),
                    
                    // Bookmark Button
                    Positioned(
                      top: KSizes.padding3x,
                      right: KSizes.padding3x,
                      child: GestureDetector(
                        onTap: () => _removeBookmark(index),
                        child: Container(
                          width: KSizes.iconL,
                          height: KSizes.iconL,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bookmark,
                            color: KColors.bookmark,
                            size: KSizes.iconS,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(KSizes.padding4x),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      news.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: KSizes.margin2x),
                    
                    // Description
                    Text(
                      news.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: KColors.textSecondary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: KSizes.margin3x),
                    
                    // Meta Info
                    Row(
                      children: [
                        Text(
                          news.source,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        Text(
                          '${news.readTime} min read',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: KColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatDate(news.publishedAt ?? DateTime.now()),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: KColors.textSecondary,
                          ),
                        ),
                      ],
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

  void _removeBookmark(int index) {
    setState(() {
      _bookmarkedNews.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bookmark removed'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareNews(NewsModel news) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${news.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Bookmarks'),
        content: const Text('Are you sure you want to remove all bookmarked articles?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _bookmarkedNews.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All bookmarks cleared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: KColors.error),
            ),
          ),
        ],
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
