import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../models/hero_story_model.dart';

class HeroStoryDetailScreen extends StatelessWidget {
  final HeroStoryModel hero;

  const HeroStoryDetailScreen({
    super.key,
    required this.hero,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 350,
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
              IconButton(
                onPressed: () {
                  // Share hero story
                },
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
                    hero.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: KColors.primary,
                        child: const Icon(
                          Icons.person,
                          size: KSizes.iconXXL,
                          color: Colors.white,
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
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Hero Name at Bottom
                  Positioned(
                    left: KSizes.padding6x,
                    right: KSizes.padding6x,
                    bottom: KSizes.padding6x,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          hero.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: KSizes.fontSizeXXL,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: KSizes.margin1x),
                        Text(
                          hero.title,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: KSizes.fontSizeL,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
                  // Hero Info Cards
                  Row(
                    children: [
                      if (hero.dateOfBirth != null)
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            'Born',
                            _formatDate(hero.dateOfBirth!),
                            Icons.cake,
                          ),
                        ),
                      if (hero.dateOfBirth != null && hero.dateOfSacrifice != null)
                        const SizedBox(width: KSizes.margin3x),
                      if (hero.dateOfSacrifice != null)
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            'Sacrifice',
                            _formatDate(hero.dateOfSacrifice!),
                            Icons.favorite,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Regiment
                  if (hero.regiment.isNotEmpty)
                    _buildInfoCard(
                      context,
                      'Regiment',
                      hero.regiment,
                      Icons.military_tech,
                    ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Awards
                  if (hero.awards.isNotEmpty) ...[
                    Text(
                      'Awards & Honors',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: KSizes.margin3x),
                    Wrap(
                      spacing: KSizes.margin2x,
                      runSpacing: KSizes.margin2x,
                      children: hero.awards.map((award) => _buildAwardChip(award)).toList(),
                    ),
                    const SizedBox(height: KSizes.margin6x),
                  ],
                  
                  // Story
                  Text(
                    'Story',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin3x),
                  
                  Text(
                    hero.shortDescription,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  Text(
                    hero.fullStory,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
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

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(KSizes.padding4x),
      decoration: BoxDecoration(
        color: KColors.backgroundCard,
        borderRadius: BorderRadius.circular(KSizes.radiusM),
        border: Border.all(color: KColors.border),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: KSizes.iconM,
            color: KColors.primary,
          ),
          const SizedBox(width: KSizes.margin2x),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KColors.textSecondary,
                  ),
                ),
                const SizedBox(height: KSizes.margin1x),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAwardChip(String award) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.padding3x,
        vertical: KSizes.padding2x,
      ),
      decoration: BoxDecoration(
        color: KColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(KSizes.radiusM),
        border: Border.all(color: KColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.military_tech,
            size: KSizes.iconS,
            color: KColors.primary,
          ),
          const SizedBox(width: KSizes.margin1x),
          Text(
            award,
            style: const TextStyle(
              color: KColors.primary,
              fontSize: KSizes.fontSizeS,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
