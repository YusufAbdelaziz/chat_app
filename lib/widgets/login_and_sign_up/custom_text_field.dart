import 'file:///C:/Users/yusse/Documents/Work/chat_app/lib/screens/login_screen/login_screen_form.dart';
import 'file:///C:/Users/yusse/Documents/Work/chat_app/lib/screens/sign_up_screen/sign_up_screen_form.dart';
import 'package:flutter/material.dart';

/// This widget is used in [LoginScreen] and [SignUpScreen] to get the email and password for
/// authentication.
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final Function onChanged;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final Widget icon;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final Function onSubmitted;
  const CustomTextField(
      {@required this.labelText,
      @required this.obscureText,
      @required this.suffixIcon,
      @required this.icon,
      @required this.focusNode,
      @required this.onSubmitted,
      @required this.errorText,
      @required this.textInputType,
      @required this.textEditingController,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3),
      width: width - 50,
      constraints: BoxConstraints(minHeight: 50, maxHeight: 90),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onSubmitted: onSubmitted,
        keyboardType: textInputType,
        controller: textEditingController,
        focusNode: focusNode,
        style: TextStyle(fontSize: 18),
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            labelStyle: TextStyle(fontSize: 16),
            errorText: errorText,
            icon: icon,
            suffixIcon: suffixIcon),
        onChanged: onChanged,
        cursorColor: Theme.of(context).cursorColor,
      ),
    );
  }
}
