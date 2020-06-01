import 'package:chatapp/bloc/sign_up_blocs/sign_up_email_bloc/bloc.dart';
import 'package:chatapp/bloc/sign_up_blocs/sign_up_password_bloc/bloc.dart';
import 'package:chatapp/screens/sign_up_screen/sign_up_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      )
    ], child: SignUpScreenForm());
  }
}
