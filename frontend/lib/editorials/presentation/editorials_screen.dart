import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../auth/application/auth_cubit.dart';
import '../../auth/application/auth_state.dart';
import '../../profile/presentation/profile_screen.dart';
import '../domain/editorial_model.dart';
import '../widgets/editorial_deck_widget.dart';
import '../widgets/expanded_editorial_detail.dart';
import '../../home/widgets/notifications_screen.dart';

class EditorialsScreen extends StatefulWidget {
  const EditorialsScreen({super.key});

  @override
  State<EditorialsScreen> createState() => _EditorialsScreenState();
}

class _EditorialsScreenState extends State<EditorialsScreen> {
  // Mock editorial data - will be replaced with real data from API
  final List<EditorialModel> _mockEditorials = [
    EditorialModel(
      id: '1',
      title: 'The Strategic Importance of Defense Modernization in Contemporary India',
      description: 'As India navigates complex geopolitical challenges, the modernization of its defense capabilities emerges as a critical imperative. This editorial examines the multifaceted approach required to strengthen national security while fostering indigenous defense manufacturing.',
      content: 'In an era marked by evolving security threats and technological advancement, India\'s defense modernization stands as a cornerstone of national strategy...',
      author: 'Dr. Rajesh Kumar',
      publication: 'The Strategic Review',
      category: EditorialCategory.analysis,
      tags: ['Defense', 'Modernization', 'Strategy', 'National Security'],
      readTime: 8,
      publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    EditorialModel(
      id: '2',
      title: 'Bridging the Civil-Military Divide: Lessons from Recent Conflicts',
      description: 'The relationship between civilian leadership and military command has profound implications for democratic governance and effective defense policy. This piece explores how modern democracies can maintain this delicate balance.',
      content: 'The civil-military relationship forms the bedrock of democratic defense governance...',
      author: 'General (Retd.) Vikram Singh',
      publication: 'Defense & Democracy',
      category: EditorialCategory.opinion,
      tags: ['Civil-Military', 'Democracy', 'Governance', 'Leadership'],
      readTime: 6,
      publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    EditorialModel(
      id: '3',
      title: 'Technology Transfer and Indigenous Innovation: A Path Forward',
      description: 'India\'s quest for defense self-reliance requires a nuanced understanding of technology transfer mechanisms and the cultivation of indigenous innovation ecosystems.',
      content: 'The journey toward defense self-reliance is paved with technological challenges and opportunities...',
      author: 'Prof. Anita Sharma',
      publication: 'Innovation Today',
      category: EditorialCategory.perspective,
      tags: ['Technology', 'Innovation', 'Self-Reliance', 'Manufacturing'],
      readTime: 7,
      publishedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    EditorialModel(
      id: '4',
      title: 'Regional Security Architecture: India\'s Role in Shaping Tomorrow',
      description: 'As regional dynamics shift and new alliances form, India\'s strategic positioning becomes increasingly crucial for maintaining stability and promoting cooperative security frameworks.',
      content: 'The evolving regional security landscape presents both challenges and opportunities for India...',
      author: 'Ambassador Priya Nair',
      publication: 'Diplomatic Quarterly',
      category: EditorialCategory.commentary,
      tags: ['Regional Security', 'Diplomacy', 'Alliances', 'Strategy'],
      readTime: 9,
      publishedAt: DateTime.now().subtract(const Duration(hours: 18)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            _buildTopNavBar(context),

            // Main Content - Editorial Cards
            Expanded(
              child: _buildEditorialCards(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.padding6x,
        vertical: KSizes.padding4x,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Avatar
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  width: KSizes.avatarM,
                  height: KSizes.avatarM,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: (state.user?.profileImageUrl.isNotEmpty == true)
                      ? ClipOval(
                          child: Image.network(
                            state.user!.profileImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultAvatar(state.user?.name ?? 'U');
                            },
                          ),
                        )
                      : _buildDefaultAvatar(state.user?.name ?? 'U'),
                ),
              );
            },
          ),

          // Title
          Column(
            children: [
              const Text(
                'EDITORIALS',
                style: TextStyle(
                  fontSize: KSizes.fontSizeXL,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.black,
                  fontFamily: 'serif',
                ),
              ),
              Container(
                height: 2,
                width: 60,
                color: Colors.black,
              ),
            ],
          ),

          // Notifications
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            child: Container(
              width: KSizes.avatarM,
              height: KSizes.avatarM,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: KSizes.iconM,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: const TextStyle(
          color: Colors.white,
          fontSize: KSizes.fontSizeL,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEditorialCards() {
    return EditorialDeckWidget(
      editorials: _mockEditorials,
      onEditorialTap: _openFullEditorial,
      onBookmarkTap: _toggleBookmark,
      onShareTap: _shareEditorial,
      onEndReached: _showEndOfEditorialsDialog,
    );
  }

  void _openFullEditorial(EditorialModel editorial) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpandedEditorialDetail(
          editorial: editorial,
          onBookmarkTap: () => _toggleBookmark(_mockEditorials.indexOf(editorial)),
          onShareTap: () => _shareEditorial(editorial),
        ),
      ),
    );
  }

  void _toggleBookmark(int index) {
    setState(() {
      _mockEditorials[index] = _mockEditorials[index].copyWith(
        isBookmarked: !_mockEditorials[index].isBookmarked,
      );
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _mockEditorials[index].isBookmarked 
              ? 'Added to bookmarks' 
              : 'Removed from bookmarks',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _shareEditorial(EditorialModel editorial) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${editorial.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showEndOfEditorialsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All caught up!'),
        content: const Text('You\'ve read all the latest editorials. Check back later for more insights.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
