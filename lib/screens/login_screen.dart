import 'package:chatapp/screens/sign_up_screen.dart';
import 'package:chatapp/widgets/login/custom_button.dart';
import 'package:chatapp/widgets/login/custom_text_field.dart';
import 'package:chatapp/widgets/login/social_media_sign_in.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        body: Center(
          child: SingleChildScrollView(
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
                CustomTextField(
                  focusNode: _emailFocusNode,
                  onSubmitted: (email) {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).autofocus(_passwordFocusNode);
                  },
                  icon: Icon(Icons.email),
                  onChanged: (text) {},
                  errorText: null,
                  labelText: 'Email',
                  obscureText: false,
                  textEditingController: _emailController,
                  textInputType: TextInputType.text,
                  suffixIcon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  suffixIcon: GestureDetector(
                    child: IconButton(
                      icon: Icon(Icons.visibility_off),

                      /// TODO :  Make bloc to change password visibility
                      onPressed: () => print('turn visibility on !'),
                    ),
                    onTap: () => print('visibility on !'),
                  ),
                  focusNode: _passwordFocusNode,
                  icon: Icon(Icons.lock),
                  onSubmitted: (password) {
                    print(password);
                  },
                  onChanged: (password) => print(password),
                  errorText: null,
                  labelText: 'Password',
                  obscureText: true,
                  textEditingController: _passwordController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),

                /// TODO : Make bloc to login
                CustomButton(
                  text: 'Login',
                  onTap: () => print('login'),
                ),
                SizedBox(
                  height: 20,
                ),
                SocialMediaSignIn(
                  onPressed: () => print('google'),
                  text: 'Sign in with Google',
                  imageAsset: 'assets/images/google-logo.png',
                ),
                SizedBox(
                  height: 10,
                ),
                SocialMediaSignIn(
                  onPressed: () => print('facebook'),
                  text: 'Sign in with Facebook',
                  imageAsset: 'assets/images/facebook-logo.png',
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
        ));
  }
}
