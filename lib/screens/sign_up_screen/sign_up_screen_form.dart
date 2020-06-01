import 'package:chatapp/bloc/sign_up_blocs/sign_up_email_bloc/bloc.dart';
import 'package:chatapp/bloc/sign_up_blocs/sign_up_password_bloc/bloc.dart';
import '../../widgets/login_and_sign_up/custom_text_field.dart';
import '../../widgets/login_and_sign_up/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreenForm extends StatefulWidget {
  @override
  _SignUpScreenFormState createState() => _SignUpScreenFormState();
}

class _SignUpScreenFormState extends State<SignUpScreenForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _reEnterPasswordController;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _reEnterPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _reEnterPasswordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _reEnterPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
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

                /// TODO : Make sign up work
                CustomButton(
                  text: 'Sign Up',
                  onTap: () {
                    if (isEmailAndPasswordValid(context)) {
                      /// TODO : Make authentication work
                      print('Let\'s Sign Up !');
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Please Enter a valid password and email',
                        ),
                        action: SnackBarAction(
                          onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                          label: 'Hide',
                          textColor: Theme.of(context).primaryColor,
                        ),
                      ));
                    }
                  },
                ),
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

  bool isEmailAndPasswordValid(BuildContext context) {
    final currentPasswordState = BlocProvider.of<SignUpPasswordBloc>(context).state;
    final currentEmailState = BlocProvider.of<SignUpEmailBloc>(context).state;
    final isPasswordNotEmpty = _passwordController.text.isNotEmpty;
    final isRePasswordNotEmpty = _reEnterPasswordController.text.isNotEmpty;
    final isEmailNotEmpty = _emailController.text.isNotEmpty;
    return currentPasswordState is ValidSignUpPasswords &&
        currentEmailState is ValidSignUpEmail &&
        isPasswordNotEmpty &&
        isRePasswordNotEmpty &&
        isEmailNotEmpty;
  }
}
