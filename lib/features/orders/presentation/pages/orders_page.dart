import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Orders page - Active orders
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: Text('Orders Page - Empty'),
      ),
    );
  }
}
