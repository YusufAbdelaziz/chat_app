import 'package:chatapp/bloc/login_blocs/login_email_bloc/bloc.dart';
import 'package:chatapp/bloc/login_blocs/login_password_bloc/bloc.dart';
import 'package:chatapp/bloc/login_blocs/password_visibility_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen_form.dart';

class LoginScreen extends StatelessWidget {
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
        )
      ],
      child: LoginScreenForm(),
    );
  }
}
