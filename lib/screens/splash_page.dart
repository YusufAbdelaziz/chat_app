import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/blocs/auth_bloc/bloc.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          width: width,
          height: height,
          child: SplashScreen.callback(
            name: 'assets/rive/liquid loader.flr',
            fit: BoxFit.contain,
            startAnimation: '1',
            onError: (e, stack) => print(stack),
            onSuccess: (_) => BlocProvider.of<AuthBloc>(context).add(AuthChecked()),
            until: () => Future.delayed(Duration(seconds: 3)),
          )),
    );
  }
}
