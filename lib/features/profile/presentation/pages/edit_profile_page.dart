import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'Dhinesh');
  final _emailController = TextEditingController(text: 'dhinesh@example.com');
  final _phoneController = TextEditingController(text: '+91 9876543210');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: AppSizes.fontL,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: Column(
          children: [
            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        'D',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceXXL),

            // Form Fields
            _buildTextField(
              label: 'FULL NAME',
              controller: _nameController,
              hint: 'Enter your name',
            ),
            const SizedBox(height: AppSizes.spaceL),
            _buildTextField(
              label: 'EMAIL ADDRESS',
              controller: _emailController,
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppSizes.spaceL),
            _buildTextField(
              label: 'PHONE NUMBER',
              controller: _phoneController,
              hint: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              enabled: false, // Usually phone is verified and locked
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: ElevatedButton(
          onPressed: () {
            // Save logic
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            elevation: 0,
          ),
          child: const Text(
            'UPDATE PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: AppSizes.fontM,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.textHint,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontWeight: FontWeight.normal),
            filled: true,
            fillColor: enabled ? AppColors.white : AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
