import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/styles/app_texts.dart';
import '../../logic/favorites/favorites_bloc.dart';
import '../../logic/favorites/favorites_state.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(
        title: 'Favorites',
      ),

      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favoriteProducts.isEmpty) {
            return Center(
              child: AppTexts(
                data: 'You have no favorites yet.',
              ).SemiBold16(context,color: Colors.grey),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: state.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = state.favoriteProducts[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}