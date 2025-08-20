import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../news/domain/news_model.dart';
import '../presentation/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SwiperController _swiperController = SwiperController();
  int _currentIndex = 0;

  // Mock news data - will be replaced with real data from API
  final List<NewsModel> _mockNews = [
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
    ),
    NewsModel(
      id: '4',
      title: 'Defense Budget Allocation Increased',
      description: 'Government announces significant increase in defense budget allocation for modernization and infrastructure development.',
      content: 'The government has announced a substantial increase in defense budget allocation, focusing on modernization of armed forces...',
      imageUrl: 'https://via.placeholder.com/400x280/4CAF50/FFFFFF?text=Budget',
      source: 'Press Information Bureau',
      author: 'Economic Reporter',
      category: NewsCategory.economy,
      tags: ['Budget', 'Defense', 'Modernization', 'Infrastructure'],
      readTime: 3,
      publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
  ];

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Main Content - Swipeable Cards
            Expanded(
              child: _buildSwipeableCards(),
            ),
            
            // Bottom Actions
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(KSizes.padding6x),
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
                    KStrings.pickYourFuture,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: KSizes.margin1x),
                  Text(
                    KStrings.dailyNews,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: KColors.textSecondary,
                    ),
                  ),
                ],
              ),
              
              // Profile/Settings Icon
              IconButton(
                onPressed: () {
                  // Navigate to profile
                },
                icon: const Icon(
                  Icons.account_circle,
                  size: KSizes.iconXL,
                  color: KColors.primary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: KSizes.margin4x),
          
          // Progress Indicator
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _mockNews.length,
                  backgroundColor: KColors.border,
                  valueColor: const AlwaysStoppedAnimation<Color>(KColors.primary),
                ),
              ),
              const SizedBox(width: KSizes.margin3x),
              Text(
                '${_currentIndex + 1}/${_mockNews.length}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: KColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeableCards() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.padding4x),
      child: Swiper(
        controller: _swiperController,
        itemCount: _mockNews.length,
        itemBuilder: (context, index) {
          return NewsCard(
            news: _mockNews[index],
            onBookmarkTap: () => _toggleBookmark(index),
            onShareTap: () => _shareNews(_mockNews[index]),
            onReadMoreTap: () => _readFullNews(_mockNews[index]),
          );
        },
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        layout: SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width * 0.85,
        itemHeight: KSizes.cardHeight,
        loop: false,
        duration: KSizes.animationMedium,
        curve: Curves.easeInOut,
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(KSizes.padding6x),
      child: Column(
        children: [
          // Action Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.close,
                label: 'Skip',
                color: KColors.error,
                onTap: _skipNews,
              ),
              _buildActionButton(
                icon: Icons.bookmark_outline,
                label: 'Save',
                color: KColors.bookmark,
                onTap: _bookmarkNews,
              ),
              _buildActionButton(
                icon: Icons.favorite_outline,
                label: 'Like',
                color: KColors.primary,
                onTap: _likeNews,
              ),
            ],
          ),
          
          const SizedBox(height: KSizes.margin4x),
          
          // Continue Reading Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _currentIndex < _mockNews.length - 1 ? null : _showEndOfCards,
              child: Text(
                _currentIndex < _mockNews.length - 1 
                    ? KStrings.keepReading 
                    : KStrings.endOfCards,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: KSizes.iconXXL,
            height: KSizes.iconXXL,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(
              icon,
              color: color,
              size: KSizes.iconL,
            ),
          ),
          const SizedBox(height: KSizes.margin1x),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleBookmark(int index) {
    setState(() {
      _mockNews[index] = _mockNews[index].copyWith(
        isBookmarked: !_mockNews[index].isBookmarked,
      );
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _mockNews[index].isBookmarked 
              ? 'Added to bookmarks' 
              : 'Removed from bookmarks',
        ),
        duration: const Duration(seconds: 1),
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

  void _readFullNews(NewsModel news) {
    // Navigate to full news article
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: ${news.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _skipNews() {
    if (_currentIndex < _mockNews.length - 1) {
      _swiperController.next();
    }
  }

  void _bookmarkNews() {
    _toggleBookmark(_currentIndex);
  }

  void _likeNews() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Liked!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showEndOfCards() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(KStrings.endOfCards),
        content: const Text('You\'ve reached the end of today\'s news cards.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to more news or quiz
            },
            child: const Text(KStrings.attemptQuiz),
          ),
        ],
      ),
    );
  }
}
