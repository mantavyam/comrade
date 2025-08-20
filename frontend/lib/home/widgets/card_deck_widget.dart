import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../news/domain/news_model.dart';
import 'news_card.dart';

class CardDeckWidget extends StatefulWidget {
  final List<NewsModel> cards;
  final Function(NewsModel) onCardTap;
  final Function(int) onBookmarkTap;
  final Function(NewsModel) onShareTap;
  final VoidCallback? onEndReached;

  const CardDeckWidget({
    super.key,
    required this.cards,
    required this.onCardTap,
    required this.onBookmarkTap,
    required this.onShareTap,
    this.onEndReached,
  });

  @override
  State<CardDeckWidget> createState() => _CardDeckWidgetState();
}

class _CardDeckWidgetState extends State<CardDeckWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentIndex = 0;
  double _dragDistance = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      _dragDistance += details.delta.dy;
      // Limit drag distance
      _dragDistance = _dragDistance.clamp(-200.0, 200.0);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragDistance.abs() > 100) {
      // Swipe threshold reached
      if (_dragDistance < 0) {
        // Swipe up - next card
        _nextCard();
      } else {
        // Swipe down - previous card (if not at first)
        _previousCard();
      }
    } else {
      // Snap back
      _resetPosition();
    }
  }

  void _nextCard() {
    if (_currentIndex < widget.cards.length - 1) {
      setState(() {
        _currentIndex++;
        _dragDistance = 0;
        _isDragging = false;
      });
      _animationController.forward(from: 0);
    } else {
      // End of cards reached
      widget.onEndReached?.call();
      _resetPosition();
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _dragDistance = 0;
        _isDragging = false;
      });
      _animationController.forward(from: 0);
    } else {
      _resetPosition();
    }
  }

  void _resetPosition() {
    setState(() {
      _dragDistance = 0;
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Stack(
          alignment: Alignment.center,
          children: _buildCardStack(),
        ),
      ),
    );
  }

  List<Widget> _buildCardStack() {
    List<Widget> stackCards = [];
    
    // Show up to 3 cards in the stack
    for (int i = 0; i < 3 && (_currentIndex + i) < widget.cards.length; i++) {
      final cardIndex = _currentIndex + i;
      final card = widget.cards[cardIndex];
      
      // Calculate transforms for stacking effect
      double scale = 1.0 - (i * 0.05);
      double yOffset = i * 8.0;
      double opacity = 1.0 - (i * 0.2);
      
      // Apply drag transform to the top card
      if (i == 0 && _isDragging) {
        yOffset += _dragDistance * 0.5;
        scale += (_dragDistance.abs() / 1000);
      }
      
      stackCards.add(
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, yOffset),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: KSizes.padding4x + (i * 4),
                    ),
                    child: NewsCard(
                      news: card,
                      onTap: i == 0 ? () => widget.onCardTap(card) : null,
                      onBookmarkTap: i == 0 ? () => widget.onBookmarkTap(cardIndex) : null,
                      onShareTap: i == 0 ? () => widget.onShareTap(card) : null,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    
    return stackCards.reversed.toList();
  }
}
