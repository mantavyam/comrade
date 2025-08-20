import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../models/hero_story_model.dart';
import 'hero_story_detail_screen.dart';

class HeroStoriesListScreen extends StatelessWidget {
  const HeroStoriesListScreen({super.key});

  // Mock hero stories data
  static final List<HeroStoryModel> _mockHeroStories = [
    HeroStoryModel(
      id: '1',
      name: 'Captain Vikram Batra',
      title: 'Param Vir Chakra',
      shortDescription: 'The hero of Kargil War who made the ultimate sacrifice for the nation',
      fullStory: 'Captain Vikram Batra, PVC, was an officer of the Indian Army, posthumously awarded the Param Vir Chakra, India\'s highest military decoration, for his actions during the 1999 Kargil War in Kashmir between India and Pakistan...',
      imageUrl: 'https://via.placeholder.com/300x400/2E7D32/FFFFFF?text=Capt+Vikram+Batra',
      dateOfBirth: DateTime(1974, 9, 9),
      dateOfSacrifice: DateTime(1999, 7, 7),
      regiment: 'Jammu and Kashmir Rifles',
      awards: ['Param Vir Chakra'],
    ),
    HeroStoryModel(
      id: '2',
      name: 'Major Sandeep Unnikrishnan',
      title: 'Ashoka Chakra',
      shortDescription: 'NSG Commando who laid down his life during 26/11 Mumbai attacks',
      fullStory: 'Major Sandeep Unnikrishnan, AC, was an Indian Army officer serving in the elite 51 Special Action Group of the National Security Guard...',
      imageUrl: 'https://via.placeholder.com/300x400/FF9800/FFFFFF?text=Maj+Sandeep',
      dateOfBirth: DateTime(1977, 3, 15),
      dateOfSacrifice: DateTime(2008, 11, 28),
      regiment: 'Bihar Regiment',
      awards: ['Ashoka Chakra'],
    ),
    HeroStoryModel(
      id: '3',
      name: 'Flying Officer Nirmal Jit Singh Sekhon',
      title: 'Param Vir Chakra',
      shortDescription: 'The only Indian Air Force officer to receive Param Vir Chakra',
      fullStory: 'Flying Officer Nirmal Jit Singh Sekhon, PVC, was an Indian Air Force officer who was posthumously awarded India\'s highest military decoration, the Param Vir Chakra...',
      imageUrl: 'https://via.placeholder.com/300x400/2196F3/FFFFFF?text=FO+Nirmal+Jit',
      dateOfBirth: DateTime(1945, 7, 17),
      dateOfSacrifice: DateTime(1971, 12, 14),
      regiment: 'Indian Air Force',
      awards: ['Param Vir Chakra'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories of Guts and Glory'),
        backgroundColor: KColors.background,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(KSizes.padding4x),
        itemCount: _mockHeroStories.length,
        itemBuilder: (context, index) {
          final hero = _mockHeroStories[index];
          return _buildHeroCard(context, hero);
        },
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, HeroStoryModel hero) {
    return Container(
      margin: const EdgeInsets.only(bottom: KSizes.margin4x),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HeroStoryDetailScreen(hero: hero),
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
          child: Row(
            children: [
              // Hero Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(KSizes.radiusL),
                  bottomLeft: Radius.circular(KSizes.radiusL),
                ),
                child: SizedBox(
                  width: 120,
                  height: 140,
                  child: Image.network(
                    hero.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: KColors.primary,
                        child: const Icon(
                          Icons.person,
                          size: KSizes.iconXL,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Hero Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(KSizes.padding4x),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        hero.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: KSizes.margin1x),
                      
                      // Title/Award
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: KSizes.padding2x,
                          vertical: KSizes.padding1x,
                        ),
                        decoration: BoxDecoration(
                          color: KColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(KSizes.radiusS),
                        ),
                        child: Text(
                          hero.title,
                          style: const TextStyle(
                            color: KColors.primary,
                            fontSize: KSizes.fontSizeXS,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: KSizes.margin2x),
                      
                      // Short Description
                      Text(
                        hero.shortDescription,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KColors.textSecondary,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: KSizes.margin3x),
                      
                      // Read More
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            'Read Story',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: KColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: KSizes.margin1x),
                          const Icon(
                            Icons.arrow_forward,
                            size: KSizes.iconS,
                            color: KColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
