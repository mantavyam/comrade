import 'package:flutter/material.dart';
import '../constants/k_colors.dart';
import '../constants/k_sizes.dart';
import '../constants/k_strings.dart';
import '../../home/presentation/home_screen.dart';
import '../../profile/presentation/profile_screen.dart';

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
    const ProfileScreen(),
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
                label: KStrings.home,
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.article_outlined,
                activeIcon: Icons.article,
                label: KStrings.editorials,
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.bookmark_outline,
                activeIcon: Icons.bookmark,
                label: KStrings.bookmarks,
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.auto_stories_outlined,
                activeIcon: Icons.auto_stories,
                label: KStrings.stories,
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: KStrings.profile,
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
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: KSizes.padding2x,
          vertical: KSizes.padding1x,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: KSizes.iconM,
              color: isSelected 
                  ? KColors.bottomNavSelected 
                  : KColors.bottomNavUnselected,
            ),
            const SizedBox(height: KSizes.margin1x),
            Text(
              label,
              style: TextStyle(
                fontSize: KSizes.fontSizeXS,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected 
                    ? KColors.bottomNavSelected 
                    : KColors.bottomNavUnselected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens - will be implemented later
class EditorialsScreen extends StatelessWidget {
  const EditorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KStrings.editorials),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article,
              size: KSizes.iconXXL,
              color: KColors.textSecondary,
            ),
            SizedBox(height: KSizes.margin4x),
            Text(
              'Editorials Screen',
              style: TextStyle(
                fontSize: KSizes.fontSizeXL,
                fontWeight: FontWeight.w600,
                color: KColors.textPrimary,
              ),
            ),
            SizedBox(height: KSizes.margin2x),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: KSizes.fontSizeM,
                color: KColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KStrings.bookmarks),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark,
              size: KSizes.iconXXL,
              color: KColors.textSecondary,
            ),
            SizedBox(height: KSizes.margin4x),
            Text(
              'Bookmarks Screen',
              style: TextStyle(
                fontSize: KSizes.fontSizeXL,
                fontWeight: FontWeight.w600,
                color: KColors.textPrimary,
              ),
            ),
            SizedBox(height: KSizes.margin2x),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: KSizes.fontSizeM,
                color: KColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KStrings.stories),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories,
              size: KSizes.iconXXL,
              color: KColors.textSecondary,
            ),
            SizedBox(height: KSizes.margin4x),
            Text(
              'Stories & Quiz Screen',
              style: TextStyle(
                fontSize: KSizes.fontSizeXL,
                fontWeight: FontWeight.w600,
                color: KColors.textPrimary,
              ),
            ),
            SizedBox(height: KSizes.margin2x),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: KSizes.fontSizeM,
                color: KColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ProfileScreen is now imported from profile/presentation/profile_screen.dart
