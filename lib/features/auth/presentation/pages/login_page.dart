import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../widgets/phone_input_field.dart';

/// Login page with phone number authentication - Zomato style
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          
          // Navigate to OTP page
          final phone = '+91 ${_phoneController.text}';
          context.pushNamed(
            RouteNames.otp,
            queryParameters: {'phone': phone},
          );
          
          context.showSnackBar('OTP sent successfully!');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final topImageHeight = screenHeight * 0.3; // 30% of screen
    final overlayStartHeight = screenHeight * 0.2; // Start at 20%

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient at top 30%
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topImageHeight,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.primaryGradient,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // App icon/logo
                      AppSizes.height,
                      Container(
                        width: AppSizes.imageThumb,
                        height: AppSizes.imageThumb,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.5),
                            width: AppSizes.borderWidthThick,
                          ),
                        ),
                        child: const Icon(
                          Icons.eco_outlined,
                          size: AppSizes.iconXL,
                          color: AppColors.white,
                        ),
                      ),
                      AppSizes.heightM,
                      Text(
                        AppStrings.appName,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // White overlay container starting from 20%
          Positioned(
            top: overlayStartHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusXL),
                  topRight: Radius.circular(AppSizes.radiusXL),
                ),
              ),
              child: SingleChildScrollView(
                padding: AppSizes.paddingAllXL,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Welcome text
                      Text(
                        'Welcome Back!',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizes.heightS,
                      Text(
                        'Login to continue',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      AppSizes.heightXL,

                      // Phone number input
                      PhoneInputField(
                        controller: _phoneController,
                        enabled: !_isLoading,
                      ),

                      AppSizes.heightXL,

                      // Continue button
                      SizedBox(
                        height: AppSizes.buttonHeightL,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.radiusM),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: AppSizes.iconS,
                                  width: AppSizes.iconS,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  'Continue',
                                  style: context.textTheme.labelLarge?.copyWith(
                                    color: AppColors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),

                      AppSizes.heightXL,

                      // Terms and conditions
                      Text(
                        'By continuing, you agree to our Terms of Service and Privacy Policy',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      AppSizes.heightL,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
