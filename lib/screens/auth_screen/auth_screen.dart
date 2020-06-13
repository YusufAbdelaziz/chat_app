import 'package:chatapp/api/auth_repository.dart';
import 'package:chatapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/bloc/login_blocs/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_screen_form.dart';
import 'package:chatapp/bloc/login_blocs/login_email_bloc/bloc.dart';
import 'package:chatapp/bloc/login_blocs/login_password_bloc/bloc.dart';
import 'package:chatapp/bloc/login_blocs/password_visibility_bloc/bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginEmailBloc>(
          create: (_) => LoginEmailBloc(),
        ),
        BlocProvider<LoginPasswordBloc>(
          create: (_) => LoginPasswordBloc(),
        ),
        BlocProvider<PasswordVisibilityBloc>(
          create: (_) => PasswordVisibilityBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
        )
      ],
      child: AuthScreenForm(),
    );
  }
}
