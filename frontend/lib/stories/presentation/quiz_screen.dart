import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../models/quiz_model.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeRemaining = 900; // 15 minutes in seconds
  Timer? _timer;
  List<int?> _selectedAnswers = [];

  // Mock quiz data
  final List<QuizQuestion> _questions = [
    QuizQuestion(
      id: '1',
      question: 'Which is the highest military decoration in India?',
      options: ['Param Vir Chakra', 'Maha Vir Chakra', 'Vir Chakra', 'Ashoka Chakra'],
      correctAnswer: 0,
      explanation: 'Param Vir Chakra is the highest military decoration awarded for displaying distinguished acts of valor during wartime.',
    ),
    QuizQuestion(
      id: '2',
      question: 'Who is known as the "Missile Man of India"?',
      options: ['Vikram Sarabhai', 'Homi Bhabha', 'A.P.J. Abdul Kalam', 'C.V. Raman'],
      correctAnswer: 2,
      explanation: 'Dr. A.P.J. Abdul Kalam is known as the "Missile Man of India" for his work on the development of ballistic missile and launch vehicle technology.',
    ),
    QuizQuestion(
      id: '3',
      question: 'Which operation was launched by India in response to the Uri attack?',
      options: ['Operation Surgical Strike', 'Operation Vijay', 'Operation Parakram', 'Operation All Out'],
      correctAnswer: 0,
      explanation: 'Operation Surgical Strike was conducted by the Indian Army in September 2016 in response to the Uri attack.',
    ),
    QuizQuestion(
      id: '4',
      question: 'What does "LAC" stand for in the context of Indian borders?',
      options: ['Line of Actual Control', 'Line of Armed Control', 'Line of Administrative Control', 'Line of Air Control'],
      correctAnswer: 0,
      explanation: 'LAC stands for Line of Actual Control, which is the effective border between India and China.',
    ),
    QuizQuestion(
      id: '5',
      question: 'Which Indian Air Force base is known as the "Roof of the World"?',
      options: ['Leh', 'Daulat Beg Oldi', 'Siachen', 'Kargil'],
      correctAnswer: 1,
      explanation: 'Daulat Beg Oldi is one of the highest airfields in the world and is often referred to as the "Roof of the World".',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.filled(_questions.length, null);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _finishQuiz();
      }
    });
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _finishQuiz() {
    _timer?.cancel();
    
    // Calculate score
    _score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctAnswer) {
        _score++;
      }
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          questions: _questions,
          selectedAnswers: _selectedAnswers,
          score: _score,
          totalQuestions: _questions.length,
          timeTaken: 900 - _timeRemaining,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}/${_questions.length}'),
        backgroundColor: KColors.background,
        elevation: 0,
        actions: [
          // Timer
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: KSizes.padding3x,
              vertical: KSizes.padding1x,
            ),
            margin: const EdgeInsets.only(right: KSizes.margin4x),
            decoration: BoxDecoration(
              color: _timeRemaining < 60 ? KColors.error : KColors.primary,
              borderRadius: BorderRadius.circular(KSizes.radiusM),
            ),
            child: Text(
              _formatTime(_timeRemaining),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(KSizes.padding4x),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: KColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(KColors.primary),
            ),
          ),
          
          // Question Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(KSizes.padding6x),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question
                  Text(
                    currentQuestion.question,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin8x),
                  
                  // Options
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedAnswers[_currentQuestionIndex] == index;
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: KSizes.margin3x),
                          child: GestureDetector(
                            onTap: () => _selectAnswer(index),
                            child: Container(
                              padding: const EdgeInsets.all(KSizes.padding4x),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? KColors.primary.withValues(alpha: 0.1)
                                    : KColors.backgroundCard,
                                borderRadius: BorderRadius.circular(KSizes.radiusM),
                                border: Border.all(
                                  color: isSelected 
                                      ? KColors.primary 
                                      : KColors.border,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Option Letter
                                  Container(
                                    width: KSizes.iconL,
                                    height: KSizes.iconL,
                                    decoration: BoxDecoration(
                                      color: isSelected 
                                          ? KColors.primary 
                                          : KColors.textSecondary.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + index), // A, B, C, D
                                        style: TextStyle(
                                          color: isSelected 
                                              ? Colors.white 
                                              : KColors.textSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(width: KSizes.margin3x),
                                  
                                  // Option Text
                                  Expanded(
                                    child: Text(
                                      currentQuestion.options[index],
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: isSelected 
                                            ? KColors.primary 
                                            : KColors.textPrimary,
                                        fontWeight: isSelected 
                                            ? FontWeight.w600 
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(KSizes.padding6x),
            child: Row(
              children: [
                // Previous Button
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousQuestion,
                      child: const Text('Previous'),
                    ),
                  ),
                
                if (_currentQuestionIndex > 0)
                  const SizedBox(width: KSizes.margin3x),
                
                // Next/Finish Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedAnswers[_currentQuestionIndex] != null
                        ? (_currentQuestionIndex < _questions.length - 1 
                            ? _nextQuestion 
                            : _finishQuiz)
                        : null,
                    child: Text(
                      _currentQuestionIndex < _questions.length - 1 
                          ? 'Next' 
                          : 'Finish Quiz',
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
