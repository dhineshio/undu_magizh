import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Location badge widget with icon and text
class LocationBadge extends StatelessWidget {
  final String location;
  final VoidCallback? onTap;

  const LocationBadge({
    super.key,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingS,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusCircular),

        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.textLight,
              size: AppSizes.iconS,
            ),
            const SizedBox(width: 6),
            Text(
              location,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textLight,
              size: AppSizes.iconS,
            ),
          ],
        ),
      ),
    );
  }
}
