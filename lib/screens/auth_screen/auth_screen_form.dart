import 'package:chatapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/bloc/auth_bloc/auth_event.dart';
import 'package:chatapp/bloc/login_blocs/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/bloc/login_blocs/login_email_bloc/bloc.dart';
import 'package:chatapp/bloc/login_blocs/login_password_bloc/bloc.dart';
import 'package:chatapp/bloc/login_blocs/password_visibility_bloc/bloc.dart';
import 'package:chatapp/screens/sign_up_screen/sign_up_screen.dart';
import '../../widgets/login_and_sign_up/custom_text_field.dart';
import '../../widgets/login_and_sign_up/custom_button.dart';
import '../../widgets/login_and_sign_up/social_media_sign_in.dart';

class AuthScreenForm extends StatefulWidget {
  @override
  _AuthScreenFormState createState() => _AuthScreenFormState();
}

class _AuthScreenFormState extends State<AuthScreenForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Builder(
          builder: (context) => Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/message-logo.png',
                    height: 140,
                    width: 140,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<LoginEmailBloc, LoginEmailState>(builder: (context, state) {
                    String errorText;
                    if (state is InitialLoginEmailState) {
                      errorText = state.errorText;
                    } else if (state is InvalidLoginEmail) {
                      errorText = state.errorText;
                    }
                    return CustomTextField(
                      focusNode: _emailFocusNode,
                      onSubmitted: (_) {
                        FocusScope.of(context).autofocus(_passwordFocusNode);
                      },
                      icon: Icon(Icons.email),
                      onChanged: (email) {
                        BlocProvider.of<LoginEmailBloc>(context)
                            .add(LoginEmailChecked(email: email));
                      },
                      errorText: errorText,
                      labelText: 'Email',
                      obscureText: false,
                      textEditingController: _emailController,
                      textInputType: TextInputType.text,
                      suffixIcon: null,
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
                      builder: (context, state) {
                    bool isPasswordVisible;
                    if (state is InitialPasswordVisibilityState) {
                      isPasswordVisible = false;
                    } else {
                      isPasswordVisible = true;
                    }
                    return BlocBuilder<LoginPasswordBloc, LoginPasswordState>(
                      builder: (context, state) {
                        String errorText;
                        if (state is InitialLoginPasswordState) {
                          errorText = state.errorText;
                        } else if (state is InvalidLoginPassword) {
                          errorText = state.errorText;
                        }
                        return CustomTextField(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: IconButton(
                              icon:
                                  Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                if (isPasswordVisible) {
                                  BlocProvider.of<PasswordVisibilityBloc>(context)
                                      .add(PasswordHidden());
                                } else {
                                  BlocProvider.of<PasswordVisibilityBloc>(context)
                                      .add(PasswordShowed());
                                }
                              },
                            ),
                          ),
                          focusNode: _passwordFocusNode,
                          icon: Icon(Icons.lock),
                          onSubmitted: (_) {},
                          onChanged: (password) => BlocProvider.of<LoginPasswordBloc>(context)
                              .add(LoginPasswordChecked(password: password)),
                          errorText: errorText,
                          labelText: 'Password',
                          obscureText: isPasswordVisible ? false : true,
                          textEditingController: _passwordController,
                          textInputType: TextInputType.text,
                        );
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginError) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            state.errorMessage,
                          ),
                          backgroundColor: Theme.of(context).errorColor,
                          action: SnackBarAction(
                            onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                            label: 'Hide',
                            textColor: Theme.of(context).accentColor,
                          ),
                        ));
                      } else if (state is LoginWithEmailSuccess ||
                          state is LoginWithFacebookSuccess ||
                          state is LoginWithGoogleSuccess) {
                        BlocProvider.of<AuthBloc>(context).add(SignInAuth());
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          if (state is! LoadingLoginWithEmail)
                            CustomButton(
                              text: 'Login',
                              onTap: () async {
                                if (isEmailAndPasswordValid(context)) {
                                  BlocProvider.of<LoginBloc>(context).add(LoggedInWithEmail(
                                      email: _emailController.text,
                                      password: _passwordController.text));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      'Please Enter a valid password and email',
                                    ),
                                    backgroundColor: Theme.of(context).errorColor,
                                    action: SnackBarAction(
                                      onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                                      label: 'Hide',
                                      textColor: Theme.of(context).accentColor,
                                    ),
                                  ));
                                }
                              },
                            )
                          else
                            loadingIndicator(context),
                          SizedBox(
                            height: 20,
                          ),
                          if (state is! LoadingLoginWithGoogle)
                            SocialMediaSignIn(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(LoggedInWithGoogle());
                              },
                              text: 'Sign in with Google',
                              imageAsset: 'assets/images/google-logo.png',
                            )
                          else
                            loadingIndicator(context),
                          SizedBox(
                            height: 10,
                          ),
                          if (state is! LoadingLoginWithFacebook)
                            SocialMediaSignIn(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(LoggedInWithFacebook());
                              },
                              text: 'Sign in with Facebook',
                              imageAsset: 'assets/images/facebook-logo.png',
                            )
                          else
                            loadingIndicator(context)
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                    child: Text(
                      'Create new account',
                      style:
                          TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget loadingIndicator(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 50,
      height: 40,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
        ),
      ),
    );
  }

  bool isEmailAndPasswordValid(BuildContext context) {
    final currentPasswordState = BlocProvider.of<LoginPasswordBloc>(context).state;
    final currentEmailState = BlocProvider.of<LoginEmailBloc>(context).state;
    final isEmailNotEmpty = _emailController.text.isNotEmpty;
    final isPasswordNotEmpty = _passwordController.text.isNotEmpty;
    return currentPasswordState is InitialLoginPasswordState &&
        isPasswordNotEmpty &&
        currentEmailState is InitialLoginEmailState &&
        isEmailNotEmpty;
  }
}
