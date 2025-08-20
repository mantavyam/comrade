import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../auth/application/auth_cubit.dart';
import '../../auth/application/auth_state.dart';
import '../../auth/presentation/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state.isGuestMode) {
            return _buildGuestProfile(context);
          } else if (state.isAuthenticated && state.user != null) {
            return _buildAuthenticatedProfile(context, state);
          } else {
            return _buildLoadingProfile();
          }
        },
      ),
    );
  }

  Widget _buildGuestProfile(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(KSizes.padding6x),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Guest Icon
            Container(
              width: KSizes.avatarXXL,
              height: KSizes.avatarXXL,
              decoration: BoxDecoration(
                color: KColors.backgroundCard,
                shape: BoxShape.circle,
                border: Border.all(color: KColors.border, width: 2),
              ),
              child: const Icon(
                Icons.person_outline,
                size: KSizes.iconXL,
                color: KColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: KSizes.margin6x),
            
            // Guest Mode Title
            Text(
              KStrings.guestMode,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: KSizes.margin2x),
            
            // Limited Features Message
            Text(
              KStrings.limitedFeatures,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: KColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(KStrings.signInForFullAccess),
              ),
            ),
            
            const SizedBox(height: KSizes.margin4x),
            
            // Basic Features Available
            Container(
              padding: const EdgeInsets.all(KSizes.padding4x),
              decoration: BoxDecoration(
                color: KColors.backgroundCard,
                borderRadius: BorderRadius.circular(KSizes.radiusM),
                border: Border.all(color: KColors.border),
              ),
              child: Column(
                children: [
                  Text(
                    'Available in Guest Mode:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: KSizes.margin3x),
                  _buildFeatureItem(Icons.article, 'Read daily news'),
                  _buildFeatureItem(Icons.auto_stories, 'Browse stories'),
                  _buildFeatureItem(Icons.quiz, 'Take quizzes (limited)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthenticatedProfile(BuildContext context, AuthState state) {
    final user = state.user!;
    
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(KSizes.padding6x),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(context, user),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Stats Section
            _buildStatsSection(context, user),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Weekly Streak
            _buildWeeklyStreak(context, user),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Menu Items
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingProfile() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic user) {
    return Column(
      children: [
        // Profile Picture
        Container(
          width: KSizes.avatarXXL,
          height: KSizes.avatarXXL,
          decoration: BoxDecoration(
            color: KColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: KColors.primaryLight, width: 3),
          ),
          child: user.profileImageUrl != null && user.profileImageUrl.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    user.profileImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultAvatar(user.name);
                    },
                  ),
                )
              : _buildDefaultAvatar(user.name),
        ),
        
        const SizedBox(height: KSizes.margin4x),
        
        // Name
        Text(
          user.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: KSizes.margin1x),
        
        // Email
        if (user.email != null && user.email.isNotEmpty)
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: KColors.textSecondary,
            ),
          ),
      ],
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: const TextStyle(
          fontSize: KSizes.fontSizeXXXL,
          fontWeight: FontWeight.bold,
          color: KColors.textOnPrimary,
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, dynamic user) {
    return Container(
      padding: const EdgeInsets.all(KSizes.padding6x),
      decoration: BoxDecoration(
        color: KColors.backgroundCard,
        borderRadius: BorderRadius.circular(KSizes.radiusL),
        border: Border.all(color: KColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            KStrings.practiceStats,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: KSizes.margin6x),
          
          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  Icons.local_fire_department,
                  user.stats.currentStreak.toString(),
                  KStrings.currentStreak,
                  KColors.secondary,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  context,
                  Icons.emoji_events,
                  user.stats.bestStreak.toString(),
                  KStrings.bestStreak,
                  KColors.streak,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: KSizes.margin4x),
          
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  Icons.quiz,
                  user.stats.quizzesTaken.toString(),
                  KStrings.quizzesTaken,
                  KColors.primary,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  context,
                  Icons.schedule,
                  '${user.stats.minutesPracticed}',
                  KStrings.minutesPracticed,
                  KColors.info,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: KSizes.iconXL,
          height: KSizes.iconXL,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: KSizes.iconM,
          ),
        ),
        
        const SizedBox(height: KSizes.margin2x),
        
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        
        const SizedBox(height: KSizes.margin1x),
        
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: KColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWeeklyStreak(BuildContext context, dynamic user) {
    final weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    
    return Container(
      padding: const EdgeInsets.all(KSizes.padding6x),
      decoration: BoxDecoration(
        color: KColors.backgroundCard,
        borderRadius: BorderRadius.circular(KSizes.radiusL),
        border: Border.all(color: KColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            KStrings.streaks,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: KSizes.margin4x),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final isActive = index < user.stats.weeklyStreak.length 
                  ? user.stats.weeklyStreak[index] 
                  : false;
              
              return Column(
                children: [
                  Container(
                    width: KSizes.iconL,
                    height: KSizes.iconL,
                    decoration: BoxDecoration(
                      color: isActive 
                          ? KColors.secondary 
                          : KColors.backgroundSurface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive 
                            ? KColors.secondary 
                            : KColors.border,
                        width: 2,
                      ),
                    ),
                    child: isActive
                        ? const Icon(
                            Icons.check,
                            color: KColors.textOnSecondary,
                            size: KSizes.iconS,
                          )
                        : null,
                  ),
                  
                  const SizedBox(height: KSizes.margin1x),
                  
                  Text(
                    weekDays[index],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isActive 
                          ? KColors.secondary 
                          : KColors.textSecondary,
                      fontWeight: isActive 
                          ? FontWeight.w600 
                          : FontWeight.w400,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          Icons.settings,
          'Settings',
          () {
            // Navigate to settings
          },
        ),
        _buildMenuItem(
          context,
          Icons.help_outline,
          'Help & Support',
          () {
            // Navigate to help
          },
        ),
        _buildMenuItem(
          context,
          Icons.info_outline,
          'About',
          () {
            // Navigate to about
          },
        ),
        _buildMenuItem(
          context,
          Icons.logout,
          KStrings.signOut,
          () {
            _showSignOutDialog(context);
          },
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: KSizes.margin2x),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? KColors.error : KColors.textPrimary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? KColors.error : KColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: KColors.textSecondary,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.radiusM),
        ),
        tileColor: KColors.backgroundCard,
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KSizes.padding1x),
      child: Row(
        children: [
          Icon(
            icon,
            size: KSizes.iconS,
            color: KColors.primary,
          ),
          const SizedBox(width: KSizes.margin2x),
          Text(
            text,
            style: const TextStyle(
              color: KColors.textSecondary,
              fontSize: KSizes.fontSizeS,
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().signOut();
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: KColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
