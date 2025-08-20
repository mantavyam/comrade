import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../domain/editorial_model.dart';

class ExpandedEditorialDetail extends StatelessWidget {
  final EditorialModel editorial;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;

  const ExpandedEditorialDetail({
    super.key,
    required this.editorial,
    this.onBookmarkTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  editorial.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: onBookmarkTap,
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: onShareTap,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      editorial.publication.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: KSizes.fontSizeXL,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: 'serif',
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 100,
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 8),
                    ),
                  ],
                ),
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
                  // Category and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: KSizes.padding3x,
                          vertical: KSizes.padding1x,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(KSizes.radiusS),
                        ),
                        child: Text(
                          editorial.category.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: KSizes.fontSizeXS,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        _formatDate(editorial.publishedAt),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: KSizes.fontSizeS,
                          fontFamily: 'serif',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: KSizes.margin6x),

                  // Title
                  Text(
                    editorial.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: KSizes.fontSizeXXL,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      fontFamily: 'serif',
                    ),
                  ),

                  const SizedBox(height: KSizes.margin4x),

                  // Author and Read Time
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: KSizes.iconS,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: KSizes.margin1x),
                      Text(
                        editorial.author,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: KSizes.fontSizeM,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'serif',
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.access_time,
                        size: KSizes.iconS,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: KSizes.margin1x),
                      Text(
                        '${editorial.readTime} min read',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: KSizes.fontSizeM,
                          fontFamily: 'serif',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: KSizes.margin6x),

                  // Divider
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),

                  const SizedBox(height: KSizes.margin6x),

                  // Description
                  Text(
                    editorial.description,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: KSizes.fontSizeL,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'serif',
                    ),
                  ),

                  const SizedBox(height: KSizes.margin6x),

                  // Content
                  Text(
                    editorial.content,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: KSizes.fontSizeM,
                      height: 1.7,
                      fontFamily: 'serif',
                    ),
                  ),

                  const SizedBox(height: KSizes.margin8x),

                  // Tags
                  if (editorial.tags.isNotEmpty) ...[
                    const Text(
                      'TAGS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: KSizes.fontSizeS,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontFamily: 'serif',
                      ),
                    ),
                    const SizedBox(height: KSizes.margin3x),
                    Wrap(
                      spacing: KSizes.margin2x,
                      runSpacing: KSizes.margin2x,
                      children: editorial.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: KSizes.padding3x,
                          vertical: KSizes.padding2x,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(KSizes.radiusS),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: KSizes.fontSizeS,
                            fontFamily: 'serif',
                          ),
                        ),
                      )).toList(),
                    ),
                  ],

                  const SizedBox(height: KSizes.margin8x),

                  // Bottom Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: onBookmarkTap,
                        icon: Icon(
                          editorial.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        label: Text(
                          editorial.isBookmarked ? 'Bookmarked' : 'Bookmark',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: editorial.isBookmarked ? Colors.black : Colors.white,
                          foregroundColor: editorial.isBookmarked ? Colors.white : Colors.black,
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: onShareTap,
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ],
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

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
