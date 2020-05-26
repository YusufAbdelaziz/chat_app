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

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  onChanged: (text) => print(text),
                  errorText: null,
                  labelText: 'Email',
                  obscureText: false,
                  textEditingController: _emailController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (text) => print(text),
                  errorText: null,
                  labelText: 'Password',
                  obscureText: true,
                  textEditingController: _passwordController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'Login',
                  onTap: () => print('loginnn'),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Not a user ? ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
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
                )
              ],
            ),
          ),
        ));
  }
}
