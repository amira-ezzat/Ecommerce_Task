import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/styles/app_texts.dart';

class ShippingInfoWidget extends StatelessWidget {
  const ShippingInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : AppColors.white2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            AppImagesPaths.info,
            color: isDark ? Colors.white70 : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AppTexts(
              data: '**** **** **** 1234',
            ).SemiBold16(
              context,
              color: isDark ? Colors.white : AppColors.grey7,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? Colors.white70 : AppColors.grey7,
          ),
        ],
      ),
    );
  }
}
