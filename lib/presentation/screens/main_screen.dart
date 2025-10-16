import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/styles/app_texts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_images.dart';
import '../../logic/cart/cart_bloc.dart';
import '../../logic/cart/cart_state.dart';
import 'cart/cart_screen.dart';
import 'favorites_screen.dart';
import 'home/home_screen.dart';
import 'profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PlaceholderScreen(title: 'compass'),
    const PlaceholderScreen(title: 'Profile'),
    FavoritesScreen(),
    const PlaceholderScreen(title: 'Profile'),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem({
    required String iconPath,
    required String activeIconPath,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color iconColor;
    Color textColor;

    if (isSelected) {
      iconColor = isDarkMode ? Colors.white : AppColors.white;
      textColor = isDarkMode ? Colors.white : AppColors.white;
    } else {
      iconColor = isDarkMode ? Colors.white70 : AppColors.grey7;
      textColor = isDarkMode ? Colors.white70 : AppColors.grey7;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 6 : 0,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected ? activeIconPath : iconPath,
            height: 22,
            width: 22,
            color: iconColor,
          ),
          if (isSelected) ...[
            const SizedBox(width: 4),
            Flexible(
              child: AppTexts(
                data: label,
                overflow: TextOverflow.ellipsis,
              ).medium14(context, color: textColor),
            ),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: AppIconPaths.vector,
              activeIconPath: AppIconPaths.vector,
              label: 'Home',
              index: 0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: AppIconPaths.compass,
              activeIconPath: AppIconPaths.compass,
              label: 'Compass',
              index: 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: AppIconPaths.search,
              activeIconPath: AppIconPaths.search,
              label: 'Search',
              index: 2,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final int itemCount = (state is CartLoaded) ? state.items.length : 0;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildNavItem(
                      iconPath: AppIconPaths.heart,
                      activeIconPath: AppIconPaths.heart,
                      label: 'Cart',
                      index: 3,
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: -2,
                        top: -6,
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
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: AppIconPaths.user,
              activeIconPath: AppIconPaths.user,
              label: 'Profile',
              index: 4,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
