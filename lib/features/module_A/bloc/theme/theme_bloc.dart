import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: AppThemeData.darkMode, isDark: true)) {
    on<ThemeChange>(_onThemeChange);
  }


// every time you want to an action you have to put it into the event
  void _onThemeChange(ThemeEvent event, emit) async {
    // every time you want some response you put it into the state
    if (event.isDark) {
      emit(state.copyWith(themeData: AppThemeData.darkMode, isDark: true));
    } else {
      emit(state.copyWith(themeData: AppThemeData.lightMode, isDark: false));
    }
  }
}
