import 'package:flutter/material.dart';

import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_colors.dart';

class CategoriesList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: AppTexts(
                data: category,
              ).SemiBold14(
                context,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.white70 : Colors.black87),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) onCategorySelected(category);
              },
              backgroundColor:
              isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
              selectedColor: AppColors.blue2,
              shape: StadiumBorder(
                side: BorderSide(
                  color: isDarkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              pressElevation: 0,
            ),
          );
        },
      ),
    );
  }
}
