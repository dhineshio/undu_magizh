import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Premium User-App Active Order Tracking Card
class ActiveOrderCard extends StatelessWidget {
  final String restaurantName;
  final String status;
  final String imageUrl;
  final int estimatedTime;
  final double progress;

  const ActiveOrderCard({
    super.key,
    required this.restaurantName,
    required this.status,
    required this.imageUrl,
    required this.estimatedTime,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          // Tracking header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.radiusL),
                topRight: Radius.circular(AppSizes.radiusL),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.delivery_dining,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'LIVE TRACKING',
                  style: TextStyle(
                    color: AppColors.primary,
                    letterSpacing: 1.2,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 12,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$estimatedTime MIN',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Row(
              children: [
                // Restaurant Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantName,
                        style: const TextStyle(
                          fontSize: AppSizes.fontL,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: AppSizes.fontM,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Food Image/Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  child: Image.network(
                    imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 60,
                      color: AppColors.background,
                      child: const Icon(
                        Icons.fastfood,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Visual Progress (User App style)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.paddingM,
              0,
              AppSizes.paddingM,
              AppSizes.paddingM,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.divider.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primaryLight, AppColors.primary],
                          ),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStepIcon(Icons.receipt_long, true),
                    _buildStepIcon(Icons.restaurant, progress > 0.3),
                    _buildStepIcon(Icons.delivery_dining, progress > 0.7),
                    _buildStepIcon(Icons.home, progress >= 1.0),
                  ],
                ),
              ],
            ),
          ),

          // Tracking Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM,
              vertical: AppSizes.paddingS,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
                elevation: 0,
              ),
              child: const Text(
                'TRACK ORDER',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildStepIcon(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.divider,
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        size: 14,
        color: isActive ? AppColors.white : AppColors.divider,
      ),
    );
  }
}
