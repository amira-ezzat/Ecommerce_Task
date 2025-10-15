import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/styles/app_texts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../../data/models/product_model.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_event.dart';
import '../../logic/cart/cart_state.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          width: 42,
          height: 42,
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),

          ),
        ),
        title:  AppTexts(data: 'Product Details').Bold20(),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          Container(
            width: 48,
            height: 48,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey5,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child:_buildCartIcon(context),
          ),        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
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

            // Category and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTexts(
                  data: product.category.toUpperCase(),
                ).SemiBold16(color: AppColors.blue,),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.yellow, size: 20),
                    const SizedBox(width: 4),
                    AppTexts(
                      data: '${product.rating.rate} (${product.rating.count} reviews)',
                    ).medium14(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Product Title
            AppTexts(
             data:  product.title,
            ).manropeBold20(),
            const SizedBox(height: 12),

            // Product Price
            AppTexts(
             data:  '\$${product.price.toStringAsFixed(2)}',

            ).SemiBold16(),
            const SizedBox(height: 20),

            AppTexts(
             data:  product.description,
            ).medium16White(color: AppColors.grey7,
            ),
          ],
        ),
      ),
      // Add to Cart Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add_shopping_cart),
          label:  AppTexts(data: 'Add to Cart').SemiBold16(color: AppColors.white),
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

  Widget _buildCartIcon(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final hasItems = state is CartLoaded && state.items.isNotEmpty;
        return Stack(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                AppIconPaths.shopping,
                height: 24,
                width: 24,
                color: AppColors.black2,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),
            if (hasItems)
              Positioned(
                right: 6,
                top: 8,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}