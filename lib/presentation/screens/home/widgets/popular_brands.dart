import 'package:ecommerce_task/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_images.dart';

class PopularBrands extends StatelessWidget {
  const PopularBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final brands = [
      {'name': 'H&M', 'image': AppImagesPaths.brand2},
      {'name': 'Zara', 'image': AppImagesPaths.brand1},
      {'name': 'Lacoste', 'image': AppImagesPaths.brand3},
      {'name': 'H&M', 'image': AppImagesPaths.brand2},
      {'name': 'Zara', 'image': AppImagesPaths.brand1},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(data: 'Popular Brand').SemiBold20(context),
          const SizedBox(height: 8),
          SizedBox(
            height: 106,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final brand = brands[index];
                return Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:AppColors.grey9,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        brand['image']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AppTexts(data: brand['name']!).SemiBold14(context),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
