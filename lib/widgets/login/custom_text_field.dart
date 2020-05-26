import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final Function onChanged;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;

  const CustomTextField(
      {@required this.labelText,
      @required this.obscureText,
      @required this.errorText,
      @required this.textInputType,
      @required this.textEditingController,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: width - 50,
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: textInputType,
        controller: textEditingController,
        obscureText: obscureText,
        decoration:
            InputDecoration(labelText: labelText, border: InputBorder.none, errorText: errorText),
        onChanged: onChanged,
        cursorColor: Theme.of(context).cursorColor,
      ),
    );
  }
}
