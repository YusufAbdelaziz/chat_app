import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import 'package:chatapp/screens/sign_up_screen/sign_up_screen.dart';
import 'package:chatapp/screens/sign_up_screen/check_email_screen.dart';

/// Responsible for navigation between different pages.
class AppRouter {
  /// This is used to control the animation of each page.
  final pageTransitionType = PageTransitionType.fade;

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpScreen.routeName:
        return PageTransition(
          type: pageTransitionType,
          settings: settings,
          child: SignUpScreen(),
        );
        break;
      case CheckEmailScreen.routeName:
        return PageTransition(
            child: CheckEmailScreen(),
            type: pageTransitionType,
            settings: settings);
        break;
      default:
        return null;
    }
  }
}
