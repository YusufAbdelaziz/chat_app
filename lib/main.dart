import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import 'package:chatapp/bloc/theme_bloc/bloc.dart';
import 'package:chatapp/screens/auth_screen/auth_screen.dart';
import 'package:chatapp/screens/chat_list_screen/chat_list_screen.dart';
import 'package:chatapp/screens/sign_up_screen/check_email_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:chatapp/utilities/theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  BlocSupervisor.delegate = SimpleBlocDelegate();

  /// When app starts, fetch the user data to check authentication or theme mode.
  await UserRepository.getInstance().fetchUserData();
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
        ),
        RepositoryProvider<UserRepository>(create: (_) => UserRepository.getInstance())
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
          ),
          BlocProvider<ThemeBloc>(
            create: (context) {
              var brightness = SchedulerBinding.instance.window.platformBrightness;
              return ThemeBloc(
                  brightness: brightness,
                  userRepository: RepositoryProvider.of<UserRepository>(context))
                ..add(ThemeChecked());
            },
          )
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state is LightMode ? CustomThemeMode.light : CustomThemeMode.dark,
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
              onGenerateRoute: _router.onGenerateRoute);
        }),
      ),
    );
  }
}
