import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget leadingWidget;
  final Widget trailingWidget;
  final Function onTap;
  final EdgeInsetsGeometry padding;
  const CustomListTile(
      {@required this.title,
      @required this.padding,
      @required this.leadingWidget,
      @required this.trailingWidget,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: padding,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              leadingWidget,
              SizedBox(
                width: 20,
              ),
              Text(title, style: Theme.of(context).textTheme.headline2),
              Spacer(),
              trailingWidget
            ],
          )),
    );
  }
}
