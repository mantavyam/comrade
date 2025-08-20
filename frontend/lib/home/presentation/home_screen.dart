import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../auth/application/auth_cubit.dart';
import '../../auth/application/auth_state.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../news/domain/news_model.dart';
import '../widgets/news_card.dart';
import '../widgets/expanded_news_detail.dart';
import '../widgets/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            _buildTopNavBar(context),

            // Main Content - Scrollable Cards
            Expanded(
              child: _buildScrollableCards(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.padding6x,
        vertical: KSizes.padding4x,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Avatar
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  width: KSizes.avatarM,
                  height: KSizes.avatarM,
                  decoration: BoxDecoration(
                    color: KColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: KColors.primaryLight, width: 2),
                  ),
                  child: (state.user?.profileImageUrl.isNotEmpty == true)
                      ? ClipOval(
                          child: Image.network(
                            state.user!.profileImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultAvatar(state.user?.name ?? 'U');
                            },
                          ),
                        )
                      : _buildDefaultAvatar(state.user?.name ?? 'U'),
                ),
              );
            },
          ),

          // Title
          Column(
            children: [
              Text(
                KStrings.pickYourFuture,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Notifications Icon
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  size: KSizes.iconL,
                  color: KColors.textPrimary,
                ),
                // Notification badge
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: KColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: const TextStyle(
          fontSize: KSizes.fontSizeL,
          fontWeight: FontWeight.bold,
          color: KColors.textOnPrimary,
        ),
      ),
    );
  }

  Widget _buildScrollableCards() {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _mockNews.length,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KSizes.padding4x,
            vertical: KSizes.padding2x,
          ),
          child: NewsCard(
            news: _mockNews[index],
            onTap: () => _openFullNews(_mockNews[index]),
            onBookmarkTap: () => _toggleBookmark(index),
            onShareTap: () => _shareNews(_mockNews[index]),
          ),
        );
      },
    );
  }

  void _openFullNews(NewsModel news) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpandedNewsDetail(
          news: news,
          onBookmarkTap: () => _toggleBookmark(_mockNews.indexOf(news)),
          onShareTap: () => _shareNews(news),
        ),
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


}
