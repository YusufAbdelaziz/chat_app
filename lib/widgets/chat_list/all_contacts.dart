import 'file:///C:/Users/yusse/Documents/Work/chat_app/lib/screens/chat_screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
        color: Theme.of(context).accentColor,
        width: width,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemCount: 20,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(

                /// TODO : This is used for new messages
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: ListTile(
              onTap: () => Navigator.of(context).pushNamed(ChatScreen.routeName),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
              ),

              /// TODO : add the name of the contacts you're talking to
              title: Text('Name'),

              /// TODO : add the last message
              subtitle: Text('Last message'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// TODO : Set this as the date of the last message
                  Text(
                    '5:30 PM',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  /// TODO : Make conditional statement so you remove the new when message is seen
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      'New',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
