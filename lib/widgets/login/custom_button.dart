import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const CustomButton({@required this.onTap, @required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(10)),
      ),
      onTap: onTap,
    );
  }
}
