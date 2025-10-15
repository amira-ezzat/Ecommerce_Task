import 'package:ecommerce_task/core/utils/app_icons.dart';
import 'package:ecommerce_task/core/utils/app_images.dart';
import 'package:ecommerce_task/presentation/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/styles/app_texts.dart';
import '../../core/utils/app_colors.dart';
import '../../data/models/cart_item_model.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_event.dart';
import '../../logic/cart/cart_state.dart';
import '../../logic/favorites/favorites_bloc.dart';
import '../../logic/favorites/favorites_event.dart';
import '../../logic/favorites/favorites_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CartStarted());

    return Scaffold(
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
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: AppTexts(data:'Cart').Bold20(),
        centerTitle: true,
        actions: [
          Container(
            width: 42,
            height: 42,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                AppIconPaths.heart,
                height: 22,
                colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color!, BlendMode.srcIn),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ));
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: AppTexts(
                  data: 'Your cart is empty 🛍️',
                ).SemiBold16(color: Colors.grey),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(context, state.items[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                  ),
                ),
                _buildShippingInfo(context),
                _buildOrderSummary(context, state),
              ],
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.image,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  data: item.product.category,
                ).SemiBold12Grey(),
                const SizedBox(height: 4),
                AppTexts(
                  data: item.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).SemiBold16(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildQtyButton(
                      icon: Icons.remove,
                      onPressed: () => context.read<CartBloc>().add(
                          CartQuantityDecreased(item.product.id)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: AppTexts(
                        data: '${item.quantity}',
                      ).SemiBold16(),
                    ),
                    _buildQtyButton(
                      icon: Icons.add,
                      onPressed: () => context.read<CartBloc>().add(
                          CartQuantityIncreased(item.product.id)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, favState) {
                        final isFavorite = favState.favoriteProducts.any((p) => p.id == item.product.id);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(ToggleFavorite(product: item.product));
                          },
                        );
                      },
                    ),
                    AppTexts(
                      data: '\$${item.product.price.toStringAsFixed(2)}',
                    ).SemiBold16(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildShippingInfo(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : AppColors.white2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Image.asset(AppImagesPaths.info),
          const SizedBox(width: 10),
          Expanded(
            child: AppTexts(
              data: '**** **** **** 1234',
            ).SemiBold16(color: AppColors.grey7),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartLoaded state) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _buildSummaryRow('Total (${state.items.length} items)', '\$${state.subtotal.toStringAsFixed(2)}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildSummaryRow('Shipping fee', '\$${state.shipping.toStringAsFixed(2)}'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts(
                        data: 'Total',
                      ).SemiBold16(color: AppColors.grey7),
                      AppTexts(
                        data: '\$${state.total.toStringAsFixed(2)}',
                      ).Bold20(),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      // Checkout logic
                    },
                    child: AppTexts(
                      data: 'Checkout',
                    ).medium16White(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTexts(
          data: title,
        ).SemiBold16(color: AppColors.grey7),
        AppTexts(
          data: value,
        ).SemiBold14(),
      ],
    );
  }
}