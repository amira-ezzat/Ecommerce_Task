import 'package:ecommerce_task/core/utils/app_icons.dart';
import 'package:ecommerce_task/core/utils/app_images.dart';
import 'package:ecommerce_task/presentation/screens/cart/widgets/cart_item_widget.dart';
import 'package:ecommerce_task/presentation/screens/cart/widgets/order_summary_widget.dart';
import 'package:ecommerce_task/presentation/screens/cart/widgets/shipping_info_widget.dart';
import 'package:ecommerce_task/presentation/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/components/custom_app_bar.dart';
import '../../../core/styles/app_texts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../logic/cart/cart_bloc.dart';
import '../../../logic/cart/cart_event.dart';
import '../../../logic/cart/cart_state.dart';
import '../../../logic/favorites/favorites_bloc.dart';
import '../../../logic/favorites/favorites_event.dart';
import '../../../logic/favorites/favorites_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CartStarted());

    return Scaffold(
      appBar:CustomAppBar(
        title: 'Cart',
        showBackButton: true,
        showFavorites: true,
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
                ).SemiBold16(context,color: Colors.grey),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(item: state.items[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                  ),
                ),
                ShippingInfoWidget(),
                OrderSummaryWidget(state: state),              ],
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
