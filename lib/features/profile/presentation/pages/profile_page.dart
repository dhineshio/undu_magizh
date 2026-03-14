import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/router/route_names.dart';
import '../widgets/profile_option_tile.dart';

/// Premium Zomato-style Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Header
              _buildProfileHeader(context),

              const SizedBox(height: AppSizes.spaceM),

              // 2. Quick Action Cards (Orders, Favorites, Payments)
              _buildQuickActionCards(),

              const SizedBox(height: AppSizes.spaceL),

              // 3. Main Options List
              _buildOptionsSection('FOOD ORDERS', [
                ProfileOptionTile(
                  icon: Icons.receipt_long,
                  title: 'Your orders',
                  onTap: () {
                    context.push(RouteNames.orders);
                  },
                ),
                ProfileOptionTile(
                  icon: Icons.favorite_border,
                  title: 'Favorite orders',
                  onTap: () {
                    context.push(RouteNames.favorites);
                  },
                ),
                ProfileOptionTile(
                  icon: Icons.book_online,
                  title: 'Address book',
                  onTap: () {},
                ),
                ProfileOptionTile(
                  icon: Icons.star_border,
                  title: 'Online ordering help',
                  onTap: () {},
                  showDivider: false,
                ),
              ]),

              const SizedBox(height: AppSizes.spaceL),

              _buildOptionsSection('YOUR INFORMATION', [
                ProfileOptionTile(
                  icon: Icons.payment,
                  title: 'Payment settings',
                  onTap: () {},
                ),
                ProfileOptionTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  onTap: () {},
                ),
                ProfileOptionTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {},
                ),
                ProfileOptionTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {},
                  showDivider: false,
                ),
              ]),

              const SizedBox(height: AppSizes.spaceXL),

              // 4. Logout Button
              _buildLogoutButton(),

              const SizedBox(height: 50),

              const Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: AppColors.textHint, fontSize: 10),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                'V',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spaceM),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vinoth',
                  style: TextStyle(
                    fontSize: AppSizes.fontXXL,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  '+91 9876543210',
                  style: TextStyle(
                    fontSize: AppSizes.fontS,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push(RouteNames.editProfile),
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: Row(
        children: [
          _buildQuickCard(Icons.wallet, 'Payments', '2 Methods'),
          const SizedBox(width: AppSizes.spaceM),
          _buildQuickCard(Icons.card_giftcard, 'Offers', '4 Available'),
        ],
      ),
    );
  }

  Widget _buildQuickCard(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingM),
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
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection(String title, List<Widget> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: 8,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.textHint,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
          ),
          child: Column(children: options),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.logout, size: 18),
        label: const Text(
          'Log out',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: BorderSide(color: AppColors.error.withValues(alpha: 0.5)),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
        ),
      ),
    );
  }
}
