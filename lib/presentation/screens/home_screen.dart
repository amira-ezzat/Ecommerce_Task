import 'package:ecommerce_task/logic/theme/theme_bloc.dart';
import 'package:ecommerce_task/logic/theme/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/styles/app_texts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_images.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_state.dart';
import '../../logic/home/home_bloc.dart';
import '../../logic/home/home_event.dart';
import '../../logic/home/home_state.dart';
import '../widgets/product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cart_screen.dart';

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(
            AppIconPaths.mainLogo,
            height: 116,
            width: 116,
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSearching ? MediaQuery.of(context).size.width * 0.5 : 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey5,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                if (isSearching)
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onSubmitted: (value) {
                        debugPrint('Search for: $value');
                      },
                    ),
                  ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppIconPaths.search,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isSearching) {
                        isSearching = false;
                        searchController.clear();
                      } else {
                        isSearching = true;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
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
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return _buildLoading();
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
                      _buildLocationSection(),
                      _buildBanners(),
                      _buildPopularBrands(),
                      _buildFlashSale(),
                      _buildSectionTitle('Categories'),
                      _buildCategories(displayCategories),
                      _buildSectionTitle('Products'),
                      _buildProductGrid(filteredProducts),
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

  Widget _buildBanners() {
    final List<String> banners = [
      AppImagesPaths.banner,
    ];
    return SizedBox(
      height: 170,
      child: PageView.builder(
        itemCount: banners.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: AppColors.blue2,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      banners[index],
                      fit: BoxFit.contain,
                      scale: 5.5,
                      width: 200,
                      height: 140,
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTexts(
                        data: '50% Off Today',
                      ).medium16White(),
                      const SizedBox(height: 8),
                      AppTexts(
                        data:  'Limited-time picks\njust for you',
                      ).medium16White(),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {},
                        child:  AppTexts(
                          data:  'Shop Now',
                        ).SemiBold14(color: AppColors.blue2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildLocationSection() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,width: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey5,
                width: 1,
              ),
              color: AppColors.grey6,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 18,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                AppTexts(
                  data: 'Send To',
                ).SemiBold12Grey(),
                const SizedBox(height: 5,),
                AppTexts(
                  data: 'Brisbane, Queensland',
                  overflow: TextOverflow.ellipsis,
                ).SemiBold14(),
              ],
            ),
          ),

          const SizedBox(width: 6),
          SizedBox(
            height: 40,
            width: 92,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
              ),
              onPressed: () {},
              child: const AppTexts(
                data: 'Change',
              ).medium16White(),
            ),
          ),
        ],
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
                color: Theme.of(context).iconTheme.color,
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
                  decoration: const BoxDecoration(
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

  Widget _buildPopularBrands() {
    final brands = [
      {'name': 'H&M', 'image': AppImagesPaths.brand2},
      {'name': 'Zara', 'image': AppImagesPaths.brand1},
      {'name': 'Lacoste', 'image': AppImagesPaths.brand3},
      {'name': 'H&M', 'image': AppImagesPaths.brand2},
      {'name': 'Zara', 'image': AppImagesPaths.brand1},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            data: 'Popular Brand',
          ).SemiBold20(),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final brand = brands[index];
                return Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade50
                      ),
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        brand['image']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AppTexts(
                      data:  brand['name']!,
                    ).SemiBold14(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSale() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTexts(
                data:  'Flash Sale',
              ).SemiBold20(),
              Row(
                children: [
                  AppTexts(
                    data: 'Ends at',
                  ).SemiBold14(color: AppColors.grey7),
                  const SizedBox(width: 6,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  AppTexts(
                      data:  '1 : 24 : 02',
                    ).medium14( color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AppTexts(data: title).SemiBold20(),
    );
  }

  Widget _buildCategories(List<String> categories) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == _selectedCategory;
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: AppTexts(
                data: category,
              ).SemiBold14(
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.white70 : Colors.black87),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
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

  Widget _buildProductGrid(List<dynamic> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  width: 100,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}