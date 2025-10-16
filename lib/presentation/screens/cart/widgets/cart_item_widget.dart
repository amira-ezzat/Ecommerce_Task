import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/cart_item_model.dart';
import '../../../../logic/cart/cart_bloc.dart';
import '../../../../logic/cart/cart_event.dart';
import '../../../../logic/favorites/favorites_bloc.dart';
import '../../../../logic/favorites/favorites_state.dart';
import '../../../../logic/favorites/favorites_event.dart';
import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_colors.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            // borderRadius: BorderRadius.circular(8),
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
                AppTexts(data: item.product.category).SemiBold12Grey(
                  context,
                  color: isDark ? Colors.grey.shade400 : AppColors.grey7,
                ),
                const SizedBox(height: 4),
                AppTexts(
                  data: item.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).SemiBold16(
                  context,
                  color: isDark ? Colors.white : Colors.black,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onPressed: () => context
                          .read<CartBloc>()
                          .add(CartQuantityDecreased(item.product.id)),
                      isDark: isDark,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: AppTexts(
                        data: '${item.quantity}',
                      ).SemiBold16(
                        context,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    _QtyButton(
                      icon: Icons.add,
                      onPressed: () => context
                          .read<CartBloc>()
                          .add(CartQuantityIncreased(item.product.id)),
                      isDark: isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, favState) {
                        final isFavorite = favState.favoriteProducts
                            .any((p) => p.id == item.product.id);
                        return IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : (isDark
                                ? Colors.white70
                                : Theme.of(context).iconTheme.color),
                          ),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(
                                ToggleFavorite(product: item.product));
                          },
                        );
                      },
                    ),
                    AppTexts(
                      data: '\$${item.product.price.toStringAsFixed(2)}',
                    ).SemiBold16(
                      context,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _QtyButton({
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isDark ? Colors.white70 : AppColors.black,
        ),
      ),
    );
  }
}
