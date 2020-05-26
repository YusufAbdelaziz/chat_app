
import 'package:chatapp/screens/chat_screen/chat_screen.dart';
import 'package:chatapp/screens/chat_screen/chat_screen_bloc_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/chat_list_screen.dart';
import 'screens/login_screen.dart';
import 'package:chatapp/screens/sign_up_screen.dart';

/// This class is used to work as a supervisor to supervise the state movement from state to another

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(error);
    super.onError(bloc, error, stacktrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
              builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()}),
          primaryColor: Colors.blue,
          accentColor: Colors.white,
          cursorColor: Colors.blue,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.blue,
          fontFamily: 'Roboto',
          textTheme: TextTheme(
              headline1: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              bodyText1: TextStyle(color: Colors.white, fontSize: 16),

              /// For Contacts names
              headline4: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 14),
              button: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 18,
              ))),
      home: ChatList(),
      routes: {
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ChatScreen.routeName: (context) => ChatScreenBlocInitializer()
      },
    );
  }
}
