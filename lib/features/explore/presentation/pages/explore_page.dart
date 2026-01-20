import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Explore page - Main discovery screen
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: Text('Explore Page - Empty'),
      ),
    );
  }
}
