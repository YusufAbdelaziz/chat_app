import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.only(left: 10),
        itemBuilder: (context, index) => Text('Hola amigo'));
  }
}
