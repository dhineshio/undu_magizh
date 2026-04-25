import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool showDivider;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: 4),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.textPrimary).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.textPrimary,
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: AppSizes.fontM,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: AppSizes.fontXS,
                    color: AppColors.textSecondary,
                  ),
                )
              : null,
          trailing: const Icon(
            Icons.chevron_right,
            color: AppColors.textHint,
            size: 20,
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 60),
            child: Divider(height: 1, color: AppColors.divider),
          ),
      ],
    );
  }
}
