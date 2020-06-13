import 'package:chatapp/screens/auth_screen/auth_screen.dart';
import 'package:chatapp/screens/chat_list_screen/chat_list_screen.dart';
import 'package:chatapp/screens/sign_up_screen/check_email_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:chatapp/api/firestore_repository.dart';
import 'api/user_repository.dart';
import 'bloc/all_contacts/bloc.dart';
import 'bloc/auth_bloc/bloc.dart';
import 'utilities/app_router.dart';
import 'package:chatapp/api/auth_repository.dart';
import 'utilities/simple_bloc_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
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
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirestoreRepository>(
          create: (_) => FirestoreRepository.getInstance(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AllContactsBloc>(
            create: (context) => AllContactsBloc(
                firebaseRepository: RepositoryProvider.of<FirestoreRepository>(context))
              ..add(LoadAllContactsEvent()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context))
                  ..add(SplashScreenLoaded()),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
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
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  child: () {
                    if (state is LoadingState) {
                      return SplashPage();
                    } else if (state is AuthenticatedState) {
                      return ChatListScreen();
                    } else if (state is ValidationEmailState) {
                      return CheckEmailScreen();
                    } else {
                      return AuthScreen();
                    }
                  }(),
                  duration: Duration(milliseconds: 500),
                );
              },
            ),
            onGenerateRoute: _router.onGenerateRoute),
      ),
    );
  }
}
