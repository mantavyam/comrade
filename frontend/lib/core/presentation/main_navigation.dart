import 'package:flutter/material.dart';
import '../constants/k_colors.dart';
import '../constants/k_sizes.dart';
import '../../home/presentation/home_screen.dart';
import '../../stories/presentation/stories_screen.dart';
import '../../bookmarks/presentation/bookmarks_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const EditorialsScreen(),
    const BookmarksScreen(),
    const StoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: KColors.bottomNavBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: KSizes.elevationMedium,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: KSizes.bottomNavHeight,
          padding: const EdgeInsets.symmetric(horizontal: KSizes.padding2x),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.article_outlined,
                activeIcon: Icons.article,
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.bookmark_outline,
                activeIcon: Icons.bookmark,
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.auto_stories_outlined,
                activeIcon: Icons.auto_stories,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(KSizes.padding4x),
        child: Icon(
          isSelected ? activeIcon : icon,
          size: KSizes.iconL,
          color: isSelected
              ? KColors.bottomNavSelected
              : KColors.bottomNavUnselected,
        ),
      ),
    );
  }
}

// Placeholder screen for editorials - will be implemented later
class EditorialsScreen extends StatelessWidget {
  const EditorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.padding6x),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.article,
                  size: KSizes.iconXXL,
                  color: KColors.textSecondary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: KSizes.margin4x),
                Text(
                  'Editorials',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: KColors.textSecondary,
                  ),
                ),
                const SizedBox(height: KSizes.margin2x),
                Text(
                  'Coming Soon',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: KColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
