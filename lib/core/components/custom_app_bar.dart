import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_state.dart';
import '../../logic/theme/theme_bloc.dart';
import '../../logic/theme/theme_event.dart';
import '../../presentation/screens/cart/cart_screen.dart';
import '../../presentation/screens/favorites_screen.dart';
import '../styles/app_texts.dart';
import '../utils/app_colors.dart';
import '../utils/app_icons.dart';
import '../widget/icon_circle_button.dart';
import 'cart_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showLogo;
  final bool showSearch;
  final bool showCart;
  final bool showFavorites;
  final bool centerTitle;
  final bool enableThemeToggle;
  final TextEditingController? searchController;
  final bool isSearching;
  final VoidCallback? onSearchToggle;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.showLogo = false,
    this.showSearch = false,
    this.showCart = false,
    this.showFavorites = false,
    this.centerTitle = true,
    this.enableThemeToggle = false,
    this.searchController,
    this.isSearching = false,
    this.onSearchToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      leadingWidth: 80,
      leading: showBackButton
          ? _buildBackButton(context)
          : showLogo
          ? _buildLogo()
          : null,
      title: title != null ? AppTexts(data: title!).Bold20(context) : null,
      actions: [
        if (enableThemeToggle)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconCircleButton(
              borderColor: isDarkMode ? Colors.white : AppColors.grey5,
              icon: isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
              onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
            ),
          ),
        if (showSearch)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _buildSearchBar(context),
          ),
        if (showFavorites)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _buildFavoritesIcon(context),
          ),
        if (showCart)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconCircleButton(
                onPressed: () {  },
                borderColor: isDarkMode ? Colors.white : AppColors.grey5,

                iconWidget: _buildCartIcon(context)
            ),
          ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Transform.scale(
        scale: 1.8,
        child: SvgPicture.asset(
          AppIconPaths.mainLogo,
          height: 50,
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);

  Widget _buildSearchBar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSearching ? MediaQuery.of(context).size.width * 0.5 : 48,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode ? Colors.white : AppColors.grey5,
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
                  hintText: 'Search...',
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
            onPressed: onSearchToggle,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesIcon(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return IconCircleButton(
      borderColor: isDarkMode ? Colors.white : AppColors.grey5,
      iconWidget: SvgPicture.asset(
        AppIconPaths.heart,
        height: 22,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const FavoritesScreen(),
        ));
      },
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


}
