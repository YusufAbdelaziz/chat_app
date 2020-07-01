import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/api/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

/// Responsible of checking the current theme and switching between the different themes.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final UserRepository userRepository;
  final Brightness brightness;
  ThemeBloc({@required this.userRepository, @required this.brightness});
  @override
  ThemeState get initialState => InitialThemeState();

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChecked) {
      if (userRepository.isDarkMode == null) {
        if (brightness == Brightness.light) {
          userRepository.setUserTheme(isDarkMode: false);
          yield LightMode();
        } else {
          userRepository.setUserTheme(isDarkMode: true);
          yield DarkMode();
        }
      } else {
        if (userRepository.isDarkMode) {
          userRepository.setUserTheme(isDarkMode: true);
          yield DarkMode();
        } else {
          userRepository.setUserTheme(isDarkMode: false);
          yield LightMode();
        }
      }
    } else if (event is ThemeSwitched) {
      if (event.isDarkMode) {
        userRepository.setUserTheme(isDarkMode: true);
        yield DarkMode();
      } else {
        userRepository.setUserTheme(isDarkMode: false);
        yield LightMode();
      }
    }
  }
}
