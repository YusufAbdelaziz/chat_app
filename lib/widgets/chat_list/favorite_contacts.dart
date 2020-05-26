import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 20),
      height: 90,
      child: ListView.separated(
          separatorBuilder: (context, i) => SizedBox(
                width: 20,
              ),
          shrinkWrap: true,
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Column(
                children: <Widget>[
                  /// TODO : Add contacts images
                  CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    radius: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  /// TODO : Add contact name
                  AutoSizeText(
                    'Name',
                    minFontSize: 12,
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              )),
    );
  }
}
