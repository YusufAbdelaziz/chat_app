
import 'package:chatapp/screens/chat_screen/chat_screen.dart';
import 'package:chatapp/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
      case ChatScreen.routeName:
        return PageTransition(
          type: pageTransitionType,
          settings: settings,
          child: ChatScreen(),
        );
        break;
      default:
        return null;
    }
  }

}
