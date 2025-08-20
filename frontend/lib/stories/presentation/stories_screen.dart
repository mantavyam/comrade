import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../widgets/hero_story_card.dart';
import '../widgets/quiz_card.dart';
import 'hero_stories_list_screen.dart';
import 'quiz_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.padding6x),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Stories & Quiz',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: KSizes.margin2x),
              
              Text(
                'Inspire yourself with heroic tales and test your knowledge',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: KColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: KSizes.margin8x),
              
              // Stories Card
              Expanded(
                child: HeroStoryCard(
                  title: 'Stories of Guts and Glory',
                  description: 'Read inspiring tales of Indian armed forces heroes',
                  imageUrl: 'https://via.placeholder.com/400x280/2E7D32/FFFFFF?text=Heroes',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HeroStoriesListScreen(),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: KSizes.margin4x),
              
              // Quiz Card
              Expanded(
                child: QuizCard(
                  title: 'Today\'s Quiz',
                  description: 'Test your knowledge with current affairs',
                  questionsCount: 10,
                  timeLimit: 15,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
