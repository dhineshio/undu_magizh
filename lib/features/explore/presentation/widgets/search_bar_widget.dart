import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Read-only search bar with voice icon
class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onVoiceTap;
  final bool showBorder;

  const SearchBarWidget({
    super.key,
    this.onTap,
    this.onVoiceTap,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingM,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: showBorder
              ? Border.all(
                  color: AppColors.primary,
                  width: AppSizes.borderWidth,
                )
              : null,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: AppSizes.iconM,
            ),
            const SizedBox(width: AppSizes.spaceM),
            Expanded(
              child: Text(
                'Search for restaurants, dishes...',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
            InkWell(
              onTap: onVoiceTap,
              borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.mic,
                  color: AppColors.primary,
                  size: AppSizes.iconM,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
