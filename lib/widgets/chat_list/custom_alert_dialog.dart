import 'package:chatapp/blocs/add_friend/bloc.dart';
import 'package:chatapp/widgets/login_and_sign_up/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAlertDialog extends StatefulWidget {
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  TextEditingController _peerEmailController;
  FocusNode _peerEmailFocusNode;

  @override
  void initState() {
    super.initState();
    _peerEmailController = TextEditingController();
    _peerEmailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _peerEmailController.dispose();
    _peerEmailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AddFriendBloc>(context),
      child: BlocConsumer<AddFriendBloc, AddFriendState>(listener: (context, state) {
        if (state is AddFriendEmail) {
          Navigator.of(context).pop();
        }
      }, builder: (context, state) {
        String msgText;
        if (state is ValidEmail) {
          msgText = state.message;
        } else if (state is InvalidEmail) {
          msgText = state.errorMsg;
        } else if (state is AddFriendError) {
          msgText = state.errorMsg;
        }
        return AlertDialog(
          insetPadding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
              child: Text('Add a friend',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 18))),
          content: CustomTextField(
            icon: Icon(Icons.email),
            obscureText: false,
            focusNode: _peerEmailFocusNode,
            errorText: msgText,
            errorStyle: state is ValidEmail
                ? Theme.of(context).textTheme.headline5.copyWith(color: Colors.green, fontSize: 12)
                : null,
            textEditingController: _peerEmailController,
            onChanged: (peerEmail) {
              BlocProvider.of<AddFriendBloc>(context).add(FriendEmailChecked(peerEmail: peerEmail));
            },
            onSubmitted: (string) {},
            suffixIcon: null,
            labelText: 'Enter email',
            textInputType: TextInputType.multiline,
          ),
          actions: <Widget>[
            if (state is! AddFriendLoading)
              FlatButton(
                child: Text('Add',
                    style: state is ValidEmail
                        ? Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)
                        : Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey)),
                onPressed: () {
                  if (state is ValidEmail) {
                    BlocProvider.of<AddFriendBloc>(context)
                        .add(FriendAdded(peerEmail: _peerEmailController.text));
                  }
                },
              )
            else
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor)),
            FlatButton(
              child: Text('Cancel',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }),
    );
  }
}
