import 'package:chatapp/bloc/rive_actor/bloc.dart';
import 'package:chatapp/widgets/chat_list/custom_list_tile.dart';
import 'package:chatapp/widgets/chat_list/rive_actor.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final nightIdle = 'night_idle';
  final switchNight = 'switch_night';
  final dayIdle = 'day_idle';
  final switchDay = 'switch_day';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider<RiveActorBloc>(
      /// TODO : Change how the event is triggered with respect to the theme
      create: (context) => RiveActorBloc()..add(DayEvent(animationName: dayIdle)),
      child: Builder(
        builder: (ctx) => Drawer(
            child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Theme.of(ctx).primaryColor,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              elevation: 0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: width,
                color: Colors.amber.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Image.asset(
                        'assets/images/user.png',
                        color: Colors.black54,
                      ),
                    ),
                    FlatButton.icon(
                      onPressed: () => print('edit profile'),
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.settings,
                        size: 20,
                        color: Theme.of(ctx).buttonColor,
                      ),
                      label: Text(
                        'Change Picture',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomListTile(
                      /// TODO : Make the switch work
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      onTap: () {
                        print('button is tapped');
                        final currentState = BlocProvider.of<RiveActorBloc>(ctx).state;
                        print('current state is $currentState');
                        if (currentState is NightState) {
                          BlocProvider.of<RiveActorBloc>(ctx)
                              .add(SwitchingEvent(animationName: switchDay));
                        } else if (currentState is DayState) {
                          BlocProvider.of<RiveActorBloc>(ctx)
                              .add(SwitchingEvent(animationName: switchNight));
                        }
                      },
                      trailingWidget:
                          BlocBuilder<RiveActorBloc, RiveActorState>(builder: (ctx, state) {
                        ///So basically there's an issue
                        var isDayState = true;
                        var isNightState = true;
                        if (state is DayState) {
                          return Container(
                            height: 50,
                            width: 50,
                            child: FlareActor(
                              'assets/rive/switch.flr',
                              animation: state.animationName,
                              callback: (string) {
                                if (isDayState) {
                                  BlocProvider.of<RiveActorBloc>(ctx)
                                      .add(NightEvent(animationName: nightIdle));
                                } else {
                                  BlocProvider.of<RiveActorBloc>(ctx)
                                      .add(DayEvent(animationName: dayIdle));
                                }
                                isDayState = !isDayState;
                              },
                            ),
                          );
                        } else if (state is NightState) {
                          return Container(
                            height: 50,
                            width: 50,
                            child: FlareActor(
                              'assets/rive/switch.flr',
                              animation: state.animationName,
                              callback: (text) {
                                if (isNightState) {
                                  BlocProvider.of<RiveActorBloc>(ctx)
                                      .add(DayEvent(animationName: dayIdle));
                                } else {
                                  BlocProvider.of<RiveActorBloc>(ctx)
                                      .add(NightEvent(animationName: nightIdle));
                                }
                                isNightState = !isNightState;
                              },
                            ),
                          );
                        } else if (state is SwitchingState) {
                          return Container(
                            height: 50,
                            width: 50,
                            child: FlareActor(
                              'assets/rive/switch.flr',
                              callback: (text) => print(text),
                              animation: state.animationName,
                            ),
                          );
                        } else {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      }),
                      leadingWidget:
                          Icon(Icons.brightness_medium, color: Theme.of(ctx).buttonColor),
                      title: 'Theme mode',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomListTile(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),

                      /// TODO : implement log out functionality
                      onTap: () => print('log out'),
                      trailingWidget: Icon(Icons.navigate_next, color: Theme.of(ctx).buttonColor),
                      leadingWidget: Icon(Icons.exit_to_app, color: Theme.of(ctx).buttonColor),
                      title: 'Log out',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomListTile(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      onTap: () => showAboutDialog(
                          context: ctx,
                          applicationName: 'Chat App',
                          applicationIcon: Image.asset(
                            'assets/images/message-logo.png',
                            width: 40,
                            height: 40,
                          )),
                      trailingWidget: Icon(Icons.navigate_next, color: Theme.of(ctx).buttonColor),
                      leadingWidget: Icon(Icons.error_outline, color: Theme.of(ctx).buttonColor),
                      title: 'About',
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
