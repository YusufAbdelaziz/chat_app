import 'package:chatapp/widgets/login/custom_button.dart';
import 'package:chatapp/widgets/login/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp-screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    final space = SizedBox(
      height: 10,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            icon: Icon(Icons.email),
            suffixIcon: null,
            focusNode: _emailFocusNode,
            onSubmitted: (string) {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).autofocus(_passwordFocusNode);
            },
            onChanged: (text) => print(text),
            errorText: null,
            labelText: 'Email',
            obscureText: false,
            textEditingController: _emailController,
            textInputType: TextInputType.text,
          ),
          space,
          CustomTextField(
            focusNode: _passwordFocusNode,
            suffixIcon: null,
            icon: Icon(Icons.lock),
            onSubmitted: (string) {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).autofocus(_reEnterPasswordFocusNode);
            },
            onChanged: (text) => print(text),
            errorText: null,
            labelText: 'Password',
            obscureText: true,
            textEditingController: _passwordController,
            textInputType: TextInputType.text,
          ),
          space,
          CustomTextField(
            onChanged: (text) => print(text),
            icon: Icon(Icons.lock),
            focusNode: _reEnterPasswordFocusNode,
            suffixIcon: null,
            onSubmitted: (string) {},
            errorText: null,
            labelText: 'Re-Enter Password',
            obscureText: true,
            textEditingController: _reEnterPasswordController,
            textInputType: TextInputType.text,
          ),
          space,
          CustomButton(
            text: 'Sign Up',
            onTap: () => print('Sign upp'),
          ),
        ],
      )),
    );
  }
}
