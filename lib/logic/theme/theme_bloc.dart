import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppTheme.lightTheme)) {
    on<ToggleTheme>((event, emit) {
      final bool isDark = state.themeData.brightness == Brightness.dark;
      emit(ThemeState(
          themeData: isDark ? AppTheme.lightTheme : AppTheme.darkTheme));
    });
  }
}