import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/api/auth_repository.dart';
import 'package:chatapp/bloc/sign_up_blocs/sign_up_bloc/bloc.dart';
import 'package:chatapp/bloc/sign_up_blocs/sign_up_email_bloc/bloc.dart';
import 'package:chatapp/bloc/sign_up_blocs/sign_up_name_bloc/bloc.dart';
import 'package:chatapp/bloc/sign_up_blocs/sign_up_password_bloc/bloc.dart';
import 'package:chatapp/screens/sign_up_screen/sign_up_screen_form.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signUp-screen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SignUpEmailBloc>(
        create: (_) => SignUpEmailBloc(),
      ),
      BlocProvider<SignUpPasswordBloc>(
        create: (_) => SignUpPasswordBloc(),
      ),
      BlocProvider<SignUpNameBloc>(
        create: (_) => SignUpNameBloc(),
      ),
      BlocProvider<SignUpBloc>(
        create: (_) => SignUpBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
      )
    ], child: SignUpScreenForm());
  }
}
