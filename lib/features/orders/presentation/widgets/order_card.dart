import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Premium User-App Order Card for past orders
class OrderCard extends StatelessWidget {
  final String restaurantName;
  final String imageUrl;
  final String items;
  final String date;
  final double amount;
  final String status;
  final VoidCallback? onReorder;
  final VoidCallback? onRate;

  const OrderCard({
    super.key,
    required this.restaurantName,
    required this.imageUrl,
    required this.items,
    required this.date,
    required this.amount,
    required this.status,
    this.onReorder,
    this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDelivered = status.toLowerCase() == 'delivered';
    final bool isCancelled = status.toLowerCase() == 'cancelled';

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Image and Name
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  child: Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50,
                      height: 50,
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.restaurant, color: AppColors.primary, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantName,
                        style: const TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: AppSizes.fontXS,
                              fontWeight: FontWeight.w600,
                              color: isDelivered 
                                  ? AppColors.success 
                                  : isCancelled ? AppColors.error : AppColors.warning,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.circle, size: 4, color: AppColors.textHint),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: TextStyle(fontSize: AppSizes.fontXS, color: AppColors.textHint),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '₹${amount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: AppSizes.fontM,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, indent: AppSizes.paddingM, endIndent: AppSizes.paddingM),

          // Items description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingS),
            child: Text(
              items,
              style: TextStyle(
                fontSize: AppSizes.fontS,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingS),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.radiusM),
                bottomRight: Radius.circular(AppSizes.radiusM),
              ),
            ),
            child: Row(
              children: [
                if (isDelivered) ...[
                  OutlinedButton(
                    onPressed: onRate,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(80, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusS)),
                    ),
                    child: const Text('Rate Order', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: AppSizes.spaceM),
                ],
                ElevatedButton(
                  onPressed: onReorder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    minimumSize: const Size(80, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusS)),
                  ),
                  child: const Text('Reorder', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Get Help',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
