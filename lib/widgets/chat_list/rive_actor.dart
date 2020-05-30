import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class RiveActor extends StatelessWidget {
  final String animationName;
  final Function onFinished;
  const RiveActor({@required this.animationName, @required this.onFinished});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: FlareActor(
        'assets/rive/switch.flr',
        animation: animationName,
        callback: onFinished,
      ),
    );
  }
}
