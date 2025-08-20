import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../models/quiz_model.dart';

class QuizResultScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;
  final int score;
  final int totalQuestions;
  final int timeTaken;

  const QuizResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
    required this.totalQuestions,
    required this.timeTaken,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions * 100).round();
    final passed = percentage >= 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: KColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(KSizes.padding6x),
        child: Column(
          children: [
            // Result Header
            Container(
              padding: const EdgeInsets.all(KSizes.padding8x),
              decoration: BoxDecoration(
                color: passed ? KColors.success.withValues(alpha: 0.1) : KColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(KSizes.radiusL),
                border: Border.all(
                  color: passed ? KColors.success : KColors.error,
                ),
              ),
              child: Column(
                children: [
                  // Result Icon
                  Container(
                    width: KSizes.iconXXL,
                    height: KSizes.iconXXL,
                    decoration: BoxDecoration(
                      color: passed ? KColors.success : KColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      passed ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: KSizes.iconXL,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Result Text
                  Text(
                    passed ? 'Congratulations!' : 'Better Luck Next Time!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: passed ? KColors.success : KColors.error,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin2x),
                  
                  // Score
                  Text(
                    '$score/$totalQuestions',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin1x),
                  
                  // Percentage
                  Text(
                    '$percentage%',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: KColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Time Taken',
                    _formatTime(timeTaken),
                    Icons.timer,
                  ),
                ),
                const SizedBox(width: KSizes.margin3x),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Accuracy',
                    '$percentage%',
                    Icons.track_changes,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Questions Review
            Text(
              'Review Answers',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: KSizes.margin4x),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return _buildQuestionReview(context, index);
              },
            ),
            
            const SizedBox(height: KSizes.margin8x),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Back to Home'),
                  ),
                ),
                const SizedBox(width: KSizes.margin3x),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Retake quiz
                      Navigator.of(context).pop();
                    },
                    child: const Text('Retake Quiz'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
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
      child: Column(
        children: [
          Icon(
            icon,
            size: KSizes.iconL,
            color: KColors.primary,
          ),
          const SizedBox(height: KSizes.margin2x),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: KSizes.margin1x),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: KColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionReview(BuildContext context, int index) {
    final question = questions[index];
    final selectedAnswer = selectedAnswers[index];
    final isCorrect = selectedAnswer == question.correctAnswer;

    return Container(
      margin: const EdgeInsets.only(bottom: KSizes.margin4x),
      padding: const EdgeInsets.all(KSizes.padding4x),
      decoration: BoxDecoration(
        color: KColors.backgroundCard,
        borderRadius: BorderRadius.circular(KSizes.radiusM),
        border: Border.all(
          color: isCorrect ? KColors.success : KColors.error,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Row(
            children: [
              Container(
                width: KSizes.iconM,
                height: KSizes.iconM,
                decoration: BoxDecoration(
                  color: isCorrect ? KColors.success : KColors.error,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCorrect ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: KSizes.iconS,
                ),
              ),
              const SizedBox(width: KSizes.margin2x),
              Expanded(
                child: Text(
                  'Question ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: KSizes.margin3x),
          
          // Question Text
          Text(
            question.question,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: KSizes.margin3x),
          
          // Answer Options
          Column(
            children: question.options.asMap().entries.map((entry) {
              final optionIndex = entry.key;
              final optionText = entry.value;
              final isSelected = selectedAnswer == optionIndex;
              final isCorrectOption = optionIndex == question.correctAnswer;
              
              Color backgroundColor = KColors.backgroundSurface;
              Color borderColor = KColors.border;
              Color textColor = KColors.textPrimary;
              
              if (isCorrectOption) {
                backgroundColor = KColors.success.withValues(alpha: 0.1);
                borderColor = KColors.success;
                textColor = KColors.success;
              } else if (isSelected && !isCorrectOption) {
                backgroundColor = KColors.error.withValues(alpha: 0.1);
                borderColor = KColors.error;
                textColor = KColors.error;
              }
              
              return Container(
                margin: const EdgeInsets.only(bottom: KSizes.margin2x),
                padding: const EdgeInsets.all(KSizes.padding3x),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(KSizes.radiusS),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Text(
                      String.fromCharCode(65 + optionIndex),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: KSizes.margin2x),
                    Expanded(
                      child: Text(
                        optionText,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: isCorrectOption || isSelected 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isCorrectOption)
                      const Icon(
                        Icons.check_circle,
                        color: KColors.success,
                        size: KSizes.iconS,
                      ),
                    if (isSelected && !isCorrectOption)
                      const Icon(
                        Icons.cancel,
                        color: KColors.error,
                        size: KSizes.iconS,
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          // Explanation
          if (question.explanation.isNotEmpty) ...[
            const SizedBox(height: KSizes.margin3x),
            Container(
              padding: const EdgeInsets.all(KSizes.padding3x),
              decoration: BoxDecoration(
                color: KColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(KSizes.radiusS),
                border: Border.all(color: KColors.info.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: KColors.info,
                    size: KSizes.iconS,
                  ),
                  const SizedBox(width: KSizes.margin2x),
                  Expanded(
                    child: Text(
                      question.explanation,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: KColors.info,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }
}
