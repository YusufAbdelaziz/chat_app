import 'package:flutter/material.dart';

class SocialMediaSignIn extends StatelessWidget {
  final String imageAsset;
  final String text;
  final Function onPressed;

  const SocialMediaSignIn(
      {@required this.imageAsset, @required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.only(
            left: 40,
          ),
          width: width - 50,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: <Widget>[
              Image.asset(
                imageAsset,
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.button,
              )
            ],
          )),
    );
  }
}
