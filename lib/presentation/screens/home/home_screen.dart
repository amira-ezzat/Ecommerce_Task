import 'package:ecommerce_task/logic/theme/theme_bloc.dart';
import 'package:ecommerce_task/logic/theme/theme_event.dart';
import 'package:ecommerce_task/presentation/screens/home/widgets/flash_sale_section.dart';
import 'package:ecommerce_task/presentation/screens/home/widgets/location_section.dart';
import 'package:ecommerce_task/presentation/screens/home/widgets/popular_brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/components/cart_icon.dart';
import '../../../core/components/custom_app_bar.dart';
import '../../../core/styles/app_texts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/widget/icon_circle_button.dart';
import '../../../core/widget/loading_shimmer.dart';
import '../../../logic/cart/cart_bloc.dart';
import '../../../logic/cart/cart_state.dart';
import '../../../logic/home/home_bloc.dart';
import '../../../logic/home/home_event.dart';
import '../../../logic/home/home_state.dart';
import 'widgets/banner_slider.dart';
import 'widgets/categories_list.dart';

import '../../widgets/product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/product_grid.dart';
import 'widgets/section_title.dart';
import '../cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:CustomAppBar(
        showLogo: true,
        showSearch: true,
        enableThemeToggle: true,
        showCart: true,
        isSearching: isSearching,
        searchController: searchController,
        onSearchToggle: () {
          setState(() {
            isSearching = !isSearching;
            if (!isSearching) searchController.clear();
          });
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return  LoadingShimmer();
          }
          if (state is HomeLoaded) {
            _selectedCategory ??= 'All';

            final displayCategories = ['All', ...state.categories];

            final filteredProducts = (_selectedCategory == null || _selectedCategory == 'All')
                ? state.products
                : state.products.where((product) => product.category == _selectedCategory).toList();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(FetchHomeData());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationSection(),
                      BannerSlider(),
                      PopularBrands(),
                      FlashSaleSection(),
                      SectionTitle(title:'Categories'),
                      CategoriesList(
                        categories: displayCategories,
                        selectedCategory: _selectedCategory ?? 'All',
                        onCategorySelected: (category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                      const SectionTitle(title: 'Popular Products'),
                      ProductGrid(products: filteredProducts),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}