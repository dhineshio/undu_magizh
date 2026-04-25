import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Full-width explore card with detailed information and image carousel
class ExploreCard extends StatefulWidget {
  final List<String> images;
  final String name;
  final String cuisine;
  final double rating;
  final String distance;
  final String deliveryTime;
  final String price;
  final bool isVeg;
  final String? offer;
  final VoidCallback? onTap;

  const ExploreCard({
    super.key,
    required this.images,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.distance,
    required this.deliveryTime,
    required this.price,
    this.isVeg = true,
    this.offer,
    this.onTap,
  });

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.spaceM),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel with indicators
            Stack(
              children: [
                // Image PageView
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.radiusM),
                          topRight: Radius.circular(AppSizes.radiusM),
                        ),
                        child: Image.network(
                          widget.images[index],
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
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
                        ),
                      );
                    },
                  ),
                ),
                
                // Offer badge
                if (widget.offer != null)
                  Positioned(
                    top: AppSizes.spaceM,
                    left: AppSizes.spaceM,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingM,
                        vertical: AppSizes.paddingS,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.black.withValues(alpha: 0.8),
                            AppColors.black.withValues(alpha: 0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.radiusS),
                      ),
                      child: Text(
                        widget.offer!,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: AppSizes.fontS,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                // Indicators - bottom right
                if (widget.images.length > 1)
                  Positioned(
                    bottom: AppSizes.spaceM,
                    right: AppSizes.spaceM,
                    child: Row(
                      children: List.generate(
                        widget.images.length,
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
            
            // Details section
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and veg/non-veg indicator
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: AppSizes.fontL,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceS),
                      // Veg/Non-veg indicator
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.isVeg ? AppColors.success : AppColors.error,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: widget.isVeg ? AppColors.success : AppColors.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceXS),
                  
                  // Cuisine
                  Text(
                    widget.cuisine,
                    style: TextStyle(
                      fontSize: AppSizes.fontS,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceM),
                  
                  // Rating, Distance, Time, Price
                  Row(
                    children: [
                      // Rating
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingS,
                          vertical: AppSizes.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(AppSizes.radiusS),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: AppColors.white,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                fontSize: AppSizes.fontXS,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceM),
                      
                      // Distance
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        widget.distance,
                        style: TextStyle(
                          fontSize: AppSizes.fontXS,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceM),
                      
                      // Delivery time
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        widget.deliveryTime,
                        style: TextStyle(
                          fontSize: AppSizes.fontXS,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      
                      // Price
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
