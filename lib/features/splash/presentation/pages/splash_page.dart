import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Splash screen with gradient background
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to explore (main app) after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(RouteNames.login);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App name
              Text(
                AppStrings.appName,
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  letterSpacing: 1.5,
                ),
              ),
              AppSizes.heightS,
              // Tagline
              Text(
                'Food & Happiness',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: AppColors.white.withValues(alpha: 0.9),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
