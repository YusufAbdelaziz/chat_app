import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const Chat({@required this.documentSnapshot});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        padding: EdgeInsets.only(left: 10),
        itemBuilder: (context, index) => Text(documentSnapshot['text']));
  }
}
