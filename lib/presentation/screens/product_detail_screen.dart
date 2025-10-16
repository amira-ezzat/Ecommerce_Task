import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/styles/app_texts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../../data/models/product_model.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_event.dart';
import '../../logic/cart/cart_state.dart';
import 'cart/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(
        title: 'Product Details',
        showBackButton: true,
        showCart: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTexts(
                  data: product.category.toUpperCase(),
                ).SemiBold16(context, color: AppColors.blue),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.yellow, size: 20),
                    const SizedBox(width: 4),
                    AppTexts(
                      data: '${product.rating.rate} (${product.rating.count} reviews)',
                    ).medium14(context),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            AppTexts(
              data: product.title,
            ).Bold20(context),
            const SizedBox(height: 12),

            AppTexts(
              data: '\$${product.price.toStringAsFixed(2)}',
            ).SemiBold16(context),
            const SizedBox(height: 20),

            AppTexts(
              data: product.description,
            ).medium14(
              context,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add_shopping_cart),
          label: AppTexts(data: 'Add to Cart').SemiBold16(context, color: AppColors.white),
          onPressed: () {
            context.read<CartBloc>().add(CartProductAdded(product));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} added to cart!'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

}