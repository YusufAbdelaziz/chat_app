import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChecked extends ThemeEvent {
  @override
  List<Object> get props => [];
}

class ThemeSwitched extends ThemeEvent {
  final bool isDarkMode;

  ThemeSwitched({@required this.isDarkMode});

  @override
  List<Object> get props => [];
}
