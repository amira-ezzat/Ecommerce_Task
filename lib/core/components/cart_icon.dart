// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../logic/cart/cart_bloc.dart';
// import '../../logic/cart/cart_state.dart';
// import '../../presentation/screens/cart_screen.dart';
// import '../utils/app_icons.dart';
//
// class CartIcon extends StatelessWidget {
//   const CartIcon({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartBloc, CartState>(
//       builder: (context, state) {
//         final hasItems = state is CartLoaded && state.items.isNotEmpty;
//         return Stack(
//           children: [
//             IconButton(
//               icon: SvgPicture.asset(
//                 AppIconPaths.shopping,
//                 height: 24,
//                 width: 24,
//                 color: Theme.of(context).iconTheme.color,
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const CartScreen(),
//                   ),
//                 );
//               },
//             ),
//             if (hasItems)
//               Positioned(
//                 right: 6,
//                 top: 8,
//                 child: Container(
//                   width: 6,
//                   height: 6,
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
