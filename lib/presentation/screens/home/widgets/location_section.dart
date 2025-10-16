import 'package:flutter/material.dart';

import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_colors.dart';


class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: isDarkMode ? Colors.white : AppColors.grey5,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey5,
                width: 1,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.grey6.withOpacity(0.4)
                  : AppColors.grey6,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 18,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(data: 'Send To').SemiBold12Grey(context),
                const SizedBox(height: 5),
                AppTexts(
                  data: 'Brisbane, Queensland',
                  overflow: TextOverflow.ellipsis,
                ).SemiBold14(context),
              ],
            ),
          ),

          const SizedBox(width: 6),
          SizedBox(
            height: 40,
            width: 92,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
              ),
              onPressed: () {},
              child: AppTexts(
                data: 'Change',
              ).medium16White(context),
            ),
          ),
        ],
      ),
    );
  }
}
