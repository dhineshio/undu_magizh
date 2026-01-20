import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/empty_widget.dart';

/// History page - Order history
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: Text('History Page - Empty'),
      ),
    );
  }
}
