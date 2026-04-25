import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class FavoriteRestaurantCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final String cuisine;
  final VoidCallback onTap;

  const FavoriteRestaurantCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.cuisine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusM),
                    topRight: Radius.circular(AppSizes.radiusM),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120,
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.restaurant, color: AppColors.primary),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.fontM,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.orange),
                      const SizedBox(width: 2),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: AppSizes.fontXS,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.circle, size: 3, color: AppColors.textHint),
                      const SizedBox(width: 4),
                      Text(
                        deliveryTime,
                        style: TextStyle(
                          fontSize: AppSizes.fontXS,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cuisine,
                    style: TextStyle(
                      fontSize: AppSizes.fontXS,
                      color: AppColors.textHint,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
