import 'package:flutter/material.dart';

import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_colors.dart';


class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTexts(data: 'Flash Sale').SemiBold20(context),
              Row(
                children: [
                  AppTexts(
                    data: 'Ends at',
                  ).SemiBold14(context, color: AppColors.grey7),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppTexts(
                      data: '1 : 24 : 02',
                    ).medium14(context, color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
