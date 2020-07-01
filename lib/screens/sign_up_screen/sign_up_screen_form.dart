import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/blocs/sign_up_blocs/sign_up_email_bloc/bloc.dart';
import 'package:chatapp/blocs/sign_up_blocs/sign_up_name_bloc/bloc.dart';
import 'package:chatapp/blocs/sign_up_blocs/sign_up_password_bloc/bloc.dart';
import 'package:chatapp/blocs/auth_bloc/bloc.dart';
import 'package:chatapp/blocs/sign_up_blocs/sign_up_bloc/bloc.dart';
import '../../widgets/login_and_sign_up/custom_text_field.dart';
import '../../widgets/login_and_sign_up/custom_button.dart';

class SignUpScreenForm extends StatefulWidget {
  @override
  _SignUpScreenFormState createState() => _SignUpScreenFormState();
}

class _SignUpScreenFormState extends State<SignUpScreenForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _reEnterPasswordController;
  TextEditingController _nameController;
  FocusNode _nameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _reEnterPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _reEnterPasswordController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _reEnterPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _reEnterPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          height: height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<SignUpNameBloc, SignUpNameState>(builder: (context, state) {
                  String errorText;
                  if (state is ValidSignUpName) {
                    errorText = state.errorText;
                  } else if (state is InvalidSignUpName) {
                    errorText = state.errorText;
                  }
                  return CustomTextField(
                    focusNode: _nameFocusNode,
                    suffixIcon: null,
                    icon: Icon(Icons.person),
                    onSubmitted: (_) {
                      FocusScope.of(context).autofocus(_emailFocusNode);
                    },
                    onChanged: (name) =>
                        BlocProvider.of<SignUpNameBloc>(context).add(SignUpNameChecked(name: name)),
                    errorText: errorText,
                    labelText: 'Name',
                    obscureText: false,
                    textEditingController: _nameController,
                    textInputType: TextInputType.text,
                  );
                }),
                space,
                BlocBuilder<SignUpEmailBloc, SignUpEmailState>(builder: (context, state) {
                  String errorText;
                  if (state is ValidSignUpEmail) {
                    errorText = state.errorText;
                  } else if (state is InvalidSignUpEmail) {
                    errorText = state.errorText;
                  }
                  return CustomTextField(
                    icon: Icon(Icons.email),
                    suffixIcon: null,
                    focusNode: _emailFocusNode,
                    onSubmitted: (string) {
                      FocusScope.of(context).autofocus(_passwordFocusNode);
                    },
                    onChanged: (email) => BlocProvider.of<SignUpEmailBloc>(context)
                        .add(SignUpEmailChecked(email: email)),
                    errorText: errorText,
                    labelText: 'Email',
                    obscureText: false,
                    textEditingController: _emailController,
                    textInputType: TextInputType.text,
                  );
                }),
                space,
                BlocBuilder<SignUpPasswordBloc, SignUpPasswordState>(
                  builder: (context, state) {
                    String passwordErrorText;
                    String reEnterPasswordErrorText;
                    if (state is ValidSignUpPasswords) {
                      passwordErrorText = state.passwordErrorText;
                      reEnterPasswordErrorText = state.reEnterErrorText;
                    } else if (state is InvalidPasswords) {
                      passwordErrorText = state.passwordErrorText;
                      reEnterPasswordErrorText = state.reEnterErrorText;
                    }
                    return Column(
                      children: <Widget>[
                        CustomTextField(
                          focusNode: _passwordFocusNode,
                          suffixIcon: null,
                          icon: Icon(Icons.lock),
                          onSubmitted: (_) {
                            FocusScope.of(context).autofocus(_reEnterPasswordFocusNode);
                          },
                          onChanged: (_) => BlocProvider.of<SignUpPasswordBloc>(context).add(
                              PasswordChecked(
                                  password: _passwordController.text,
                                  reEnterPassword: _reEnterPasswordController.text)),
                          errorText: passwordErrorText,
                          labelText: 'Password',
                          obscureText: true,
                          textEditingController: _passwordController,
                          textInputType: TextInputType.text,
                        ),
                        space,
                        CustomTextField(
                          onChanged: (_) => BlocProvider.of<SignUpPasswordBloc>(context).add(
                              PasswordChecked(
                                  password: _passwordController.text,
                                  reEnterPassword: _reEnterPasswordController.text)),
                          icon: Icon(Icons.lock),
                          focusNode: _reEnterPasswordFocusNode,
                          suffixIcon: null,
                          onSubmitted: (_) {},
                          errorText: reEnterPasswordErrorText,
                          labelText: 'Re-Enter Password',
                          obscureText: true,
                          textEditingController: _reEnterPasswordController,
                          textInputType: TextInputType.text,
                        ),
                      ],
                    );
                  },
                ),
                space,
                BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
                  if (state is SignUpWithEmailSuccess) {
                    Navigator.of(context).pop();
                    BlocProvider.of<AuthBloc>(context).add(SignUpAuth());
                  } else if (state is SignUpError) {
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
                  }
                }, builder: (context, state) {
                  if (state is InitialSignUpState) {
                    return CustomButton(
                      text: 'Sign Up',
                      onTap: () {
                        if (areEmailAndPasswordAndNameValid(context)) {
                          BlocProvider.of<SignUpBloc>(context).add(SignedUpWithEmail(
                              email: _emailController.text,
                              password: _passwordController.text,
                              userName: _nameController.text));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Please Enter valid password, email, and name',
                            ),
                            action: SnackBarAction(
                              onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                              label: 'Hide',
                              textColor: Theme.of(context).primaryColor,
                            ),
                          ));
                        }
                      },
                    );
                  } else if (state is LoadingSignUpWithEmail) {
                    return loadingIndicator(context);
                  } else {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final space = SizedBox(
    height: 10,
  );
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

  bool areEmailAndPasswordAndNameValid(BuildContext context) {
    final currentPasswordState = BlocProvider.of<SignUpPasswordBloc>(context).state;
    final currentEmailState = BlocProvider.of<SignUpEmailBloc>(context).state;
    final currentNameState = BlocProvider.of<SignUpNameBloc>(context).state;
    final isNameNotEmpty = _nameController.text.isNotEmpty;
    final isPasswordNotEmpty = _passwordController.text.isNotEmpty;
    final isRePasswordNotEmpty = _reEnterPasswordController.text.isNotEmpty;
    final isEmailNotEmpty = _emailController.text.isNotEmpty;
    return currentPasswordState is ValidSignUpPasswords &&
        currentEmailState is ValidSignUpEmail &&
        currentNameState is ValidSignUpName &&
        isNameNotEmpty &&
        isPasswordNotEmpty &&
        isRePasswordNotEmpty &&
        isEmailNotEmpty;
  }
}
