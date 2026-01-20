import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Profile page - User profile and settings
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: Text('Profile Page - Empty'),
      ),
    );
  }
}
