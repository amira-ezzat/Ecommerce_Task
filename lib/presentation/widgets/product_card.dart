import 'package:flutter/material.dart';
import '../../core/styles/app_texts.dart';
import '../../core/utils/app_colors.dart';
import '../../data/models/product_model.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final Color priceColor = isDarkMode ? Colors.white : Colors.black;
    final Color oldPriceColor = isDarkMode ? Colors.grey.shade500 : AppColors.grey2;
    final Color iconColor = isDarkMode ? Colors.amber : AppColors.yellow;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ));
      },
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 0,
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator(strokeWidth: 2));
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, color: Colors.redAccent);
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppTexts(
                          data: product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).SemiBold14(context, color: textColor),
                      ),
                      const SizedBox(width: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: iconColor, size: 14),
                          const SizedBox(width: 2),
                          AppTexts(
                            data: product.rating.rate.toStringAsFixed(1),
                          ).SemiBold14(context, color: textColor),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      AppTexts(
                        data: '\$${product.price.toStringAsFixed(2)}',
                      ).SemiBold14(context, color: priceColor),
                      const SizedBox(width: 22),
                      AppTexts(
                        data: '\$1299',
                      ).SemiBold14(context, color: oldPriceColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
