import 'package:chatapp/api/firebase_repository.dart';
import 'package:chatapp/screens/chat_list_screen/chat_list_screen.dart';
import 'package:chatapp/screens/chat_screen/chat_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/all_contacts/bloc.dart';

import 'utilities/app_router.dart';
import 'utilities/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseRepository>(
          create: (context) => FirebaseRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AllContactsBloc>(
            create: (context) => AllContactsBloc(
                firebaseRepository: RepositoryProvider.of<FirebaseRepository>(context))
              ..add(LoadAllContactsEvent()),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                pageTransitionsTheme: PageTransitionsTheme(
                    builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()}),
                primaryColor: Colors.blue,
                accentColor: Colors.white,
                cursorColor: Colors.blue,
                buttonColor: Colors.black54,
                backgroundColor: Colors.white,
                scaffoldBackgroundColor: Colors.blue,
                fontFamily: 'Roboto',
                textTheme: TextTheme(

                    /// For last message.
                    headline5:
                        TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                    headline1:
                        TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    bodyText1: TextStyle(color: Colors.white, fontSize: 16),

                    /// For Contacts names
                    headline4: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 14),

                    /// Bigger Contacts name
                    headline6: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 16),

                    /// For drawer
                    headline2: TextStyle(color: Colors.black54, fontSize: 18),
                    button: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 18,
                    ))),
            home: LoginScreen(),
            onGenerateRoute: _router.onGenerateRoute),
      ),
    );
  }
}
