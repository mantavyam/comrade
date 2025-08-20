import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';

class HeroStoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const HeroStoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            KColors.primary,
                            KColors.primaryDark,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.auto_stories,
                          size: KSizes.iconXXL,
                          color: Colors.white,
                        ),
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
                        Colors.black.withValues(alpha: 0.8),
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
                    // Icon
                    Container(
                      width: KSizes.iconXL,
                      height: KSizes.iconXL,
                      decoration: BoxDecoration(
                        color: KColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_stories,
                        color: Colors.white,
                        size: KSizes.iconM,
                      ),
                    ),
                    
                    const SizedBox(height: KSizes.margin4x),
                    
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: KSizes.fontSizeXXL,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    
                    const SizedBox(height: KSizes.margin2x),
                    
                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: KSizes.fontSizeM,
                        height: 1.3,
                      ),
                    ),
                    
                    const SizedBox(height: KSizes.margin4x),
                    
                    // Read More Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KSizes.padding4x,
                        vertical: KSizes.padding2x,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(KSizes.radiusM),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Read Stories',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: KSizes.fontSizeM,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: KSizes.margin2x),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: KSizes.iconS,
                          ),
                        ],
                      ),
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
}
