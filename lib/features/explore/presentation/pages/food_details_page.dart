import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Food details page with image carousel and information
class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({super.key});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  // Static default images
  final List<String> _images = [
    'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600',
    'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600',
    'https://images.unsplash.com/photo-1633945274417-c5a8e7e2524?w=600',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Image carousel with app bar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  // Handle search
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingL,
                    vertical: AppSizes.paddingM,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(
                      AppSizes.radiusCircular,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                      const SizedBox(width: AppSizes.spaceS),
                      const Text(
                        'Search',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image carousel
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        _images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            child: const Center(
                              child: Icon(
                                Icons.restaurant,
                                size: AppSizes.iconXXL,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Gradient overlay at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.black.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Image indicators - bottom right
                  if (_images.length > 1)
                    Positioned(
                      bottom: AppSizes.paddingM,
                      right: AppSizes.paddingM,
                      child: Row(
                        children: List.generate(
                          _images.length,
                          (index) => Container(
                            width: _currentImageIndex == index ? 20.0 : 6.0,
                            height: 6.0,
                            margin: const EdgeInsets.only(right: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: _currentImageIndex == index
                                  ? AppColors.white
                                  : AppColors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Content area (to be added)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: const Text('More details coming...'),
            ),
          ),
        ],
      ),
    );
  }
}
