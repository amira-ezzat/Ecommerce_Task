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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ));
      },
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 0,
        color: Colors.white,
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
                      return const Icon(Icons.error);
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
                         data:  product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).SemiBold14(),
                      ),
                      const SizedBox(width: 6),
                      Row(
                        children: [
                           Icon(Icons.star, color: AppColors.yellow, size: 14),
                          AppTexts(
                            data: product.rating.rate.toStringAsFixed(1),
                          ).SemiBold14(),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Row(

                    children: [
                    AppTexts(
                      data:  '\$${product.price.toStringAsFixed(2)}',
                    ).SemiBold14(),
                    SizedBox(width: 22,),
                    AppTexts(
                      data:  '\$${1299}',
                    ).SemiBold14(color: AppColors.grey2),
                  ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}