import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// OTP verification page - Zomato style
class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isLoading = false;
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendTimer = 30);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  void _handleVerifyOtp(String pin) {
    if (pin.length == 6) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go(RouteNames.home);
          context.showSnackBar('OTP verified successfully!');
        }
      });
    }
  }

  void _handleResendOtp() {
    if (_resendTimer == 0) {
      context.showSnackBar('OTP sent successfully!');
      _startResendTimer();
      _pinController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final topImageHeight = screenHeight * 0.3;
    final overlayStartHeight = screenHeight * 0.2;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: context.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primary.withValues(alpha: 0.05),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

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
                child: Padding(
                  padding: AppSizes.paddingAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back, color: AppColors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.white.withValues(alpha: 0.2),
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
                  topLeft: Radius.circular(AppSizes.radiusXXL),
                  topRight: Radius.circular(AppSizes.radiusXXL),
                ),
              ),
              child: SingleChildScrollView(
                padding: AppSizes.paddingAllXL,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Verify OTP',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSizes.heightS,
                    
                    // Subtitle with phone number
                    RichText(
                      text: TextSpan(
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Enter the 6-digit code sent to\n'),
                          TextSpan(
                            text: widget.phoneNumber,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSizes.heightXXL,

                    // OTP Input
                    Pinput(
                      controller: _pinController,
                      focusNode: _focusNode,
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      showCursor: true,
                      enabled: !_isLoading,
                      onCompleted: _handleVerifyOtp,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      cursor: Container(
                        width: 2,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                        ),
                      ),
                    ),

                    AppSizes.heightXL,

                    // Resend OTP
                    Center(
                      child: _resendTimer > 0
                          ? Text(
                              'Resend OTP in ${_resendTimer}s',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            )
                          : GestureDetector(
                              onTap: _handleResendOtp,
                              child: Text(
                                'Resend OTP',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),

                    AppSizes.heightXL,

                    // Verify button
                    SizedBox(
                      height: AppSizes.buttonHeightL,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _handleVerifyOtp(_pinController.text),
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
                                'Verify & Continue',
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: AppColors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),

                    AppSizes.heightXL,

                    // Help text
                    Text(
                      'Didn\'t receive the code? Check your SMS or try again',
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

          // Loading overlay
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.black.withValues(alpha: 0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
