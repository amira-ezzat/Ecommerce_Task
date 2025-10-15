import 'package:device_preview/device_preview.dart';
import 'package:ecommerce_task/presentation/screens/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_service/api_service.dart';
import 'core/theme/app_theme.dart';
import 'logic/cart/cart_bloc.dart';
import 'logic/favorites/favorites_bloc.dart';
import 'logic/home/home_bloc.dart';
import 'logic/home/home_event.dart';
import 'logic/theme/theme_bloc.dart';
import 'logic/theme/theme_state.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(apiService: ApiService())
            ..add(FetchHomeData()),
        ),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => FavoritesBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeData.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}