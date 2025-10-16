import 'package:flutter/material.dart';
import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      AppImagesPaths.banner,
    ];

    return SizedBox(
      height: 151,
      child: PageView.builder(
        itemCount: banners.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.blue2,
                        AppColors.grey6,
                      ],
                    ),
                  ),
                ),

                Positioned(
                  right: 8,
                  bottom: -10,
                  child: Image.asset(
                    banners[index],
                    fit: BoxFit.contain,
                    height: 160,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTexts(data: '50% Off Today')
                          .SemiBold16(context, color: Colors.white),
                      const SizedBox(height: 6),
                      AppTexts(
                        data: 'Limited-time picks\njust for you',
                      ).medium16White(context),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: AppTexts(
                          data: 'Shop Now',
                        ).SemiBold14(context, color: AppColors.blue2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
