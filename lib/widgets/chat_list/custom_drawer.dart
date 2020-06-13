import 'package:chatapp/bloc/auth_bloc/bloc.dart';
import 'package:chatapp/bloc/rive_actor/bloc.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/widgets/chat_list/custom_list_tile.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final nightIdle = 'night_idle';
  final switchNight = 'switch_night';
  final dayIdle = 'day_idle';
  final switchDay = 'switch_day';
  final user = User.getInstance();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider<RiveActorBloc>(
      /// TODO : Change how the event is triggered with respect to the theme
      create: (context) =>
          RiveActorBloc()..add(DayEvent(animationName: user.isDarkMode ? nightIdle : dayIdle)),
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
                      child: user.imageUrl == null
                          ? Image.asset(
                              'assets/images/user.png',
                              color: Colors.black54,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                user.imageUrl,
                                fit: BoxFit.contain,
                              ),
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
                        String animationName;
                        if (state is NightState) {
                          animationName = state.animationName;
                        } else if (state is DayState) {
                          animationName = state.animationName;
                        } else if (state is SwitchingState) {
                          animationName = state.animationName;
                        }
                        return Container(
                          height: 50,
                          width: 50,
                          child: FlareActor(
                            'assets/rive/switch.flr',
                            animation: animationName,
                            callback: (animationName) {
                              if (animationName == switchNight) {
                                BlocProvider.of<RiveActorBloc>(ctx)
                                    .add(NightEvent(animationName: nightIdle));
                              } else if (animationName == switchDay) {
                                BlocProvider.of<RiveActorBloc>(ctx)
                                    .add(DayEvent(animationName: dayIdle));
                              }
                            },
                          ),
                        );
                      }),
                      leadingWidget:
                          Icon(Icons.brightness_medium, color: Theme.of(ctx).buttonColor),
                      title: 'Theme mode',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is ErrorState) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMessage),
                            backgroundColor: Theme.of(context).errorColor,
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'Close',
                              textColor: Colors.white,
                              onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                            ),
                          ));
                        } else if (state is LogoutSuccess) {
                          /// Don't forget to dismiss the drawer and fire the event to switch between
                          ///
                          Navigator.of(context).pop();
                          BlocProvider.of<AuthBloc>(context).add(AuthChecked());
                        }
                      },
                      child: CustomListTile(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                        onTap: () => BlocProvider.of<AuthBloc>(context).add(LoggedOut()),
                        trailingWidget: Icon(Icons.navigate_next, color: Theme.of(ctx).buttonColor),
                        leadingWidget: Icon(Icons.exit_to_app, color: Theme.of(ctx).buttonColor),
                        title: 'Log out',
                      ),
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
