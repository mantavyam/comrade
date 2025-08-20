import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../domain/editorial_model.dart';

class EditorialCard extends StatelessWidget {
  final EditorialModel editorial;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;

  const EditorialCard({
    super.key,
    required this.editorial,
    this.onTap,
    this.onBookmarkTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: KSizes.margin2x,
          vertical: KSizes.margin1x,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(KSizes.radiusL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: KSizes.elevationMedium,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(KSizes.radiusL),
          child: Column(
            children: [
              // Newspaper Header
              _buildNewspaperHeader(),
              
              // Main Content
              Expanded(
                child: _buildContent(context),
              ),
              
              // Bottom Actions
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewspaperHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.padding4x,
        vertical: KSizes.padding2x,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: Column(
        children: [
          // Publication Name
          Text(
            editorial.publication.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: KSizes.fontSizeL,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontFamily: 'serif',
            ),
          ),
          
          const SizedBox(height: KSizes.margin1x),
          
          // Date and Category
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(editorial.publishedAt),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: KSizes.fontSizeXS,
                  fontFamily: 'serif',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: KSizes.padding2x,
                  vertical: KSizes.padding1x,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(KSizes.radiusS),
                ),
                child: Text(
                  editorial.category.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: KSizes.fontSizeXS,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KSizes.padding4x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            editorial.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: KSizes.fontSizeXL,
              fontWeight: FontWeight.bold,
              height: 1.2,
              fontFamily: 'serif',
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: KSizes.margin3x),
          
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
                  fontSize: KSizes.fontSizeS,
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
                  fontSize: KSizes.fontSizeS,
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: KSizes.margin4x),
          
          // Description
          Expanded(
            child: Text(
              editorial.description,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: KSizes.fontSizeM,
                height: 1.5,
                fontFamily: 'serif',
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.padding4x,
        vertical: KSizes.padding2x,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tags
          Expanded(
            child: Wrap(
              spacing: KSizes.margin1x,
              children: editorial.tags.take(2).map((tag) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: KSizes.padding2x,
                  vertical: KSizes.padding1x,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(KSizes.radiusS),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: KSizes.fontSizeXS,
                    fontFamily: 'serif',
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Action Buttons
          Row(
            children: [
              IconButton(
                onPressed: onBookmarkTap,
                icon: Icon(
                  editorial.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: editorial.isBookmarked ? Colors.black : Colors.black54,
                  size: KSizes.iconM,
                ),
              ),
              IconButton(
                onPressed: onShareTap,
                icon: const Icon(
                  Icons.share,
                  color: Colors.black54,
                  size: KSizes.iconM,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
