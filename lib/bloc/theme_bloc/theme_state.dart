import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class InitialThemeState extends ThemeState {
  @override
  List<Object> get props => [];
}

class DarkMode extends ThemeState {
  @override
  List<Object> get props => [];
}

class LightMode extends ThemeState {
  @override
  List<Object> get props => [];
}
