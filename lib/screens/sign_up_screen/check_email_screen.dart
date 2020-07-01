import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/api/auth_repository.dart';
import 'package:chatapp/blocs/auth_bloc/bloc.dart';
import 'package:chatapp/blocs/sign_up_blocs/email_validation_bloc/bloc.dart';
import 'package:chatapp/widgets/login_and_sign_up/custom_button.dart';


class CheckEmailScreen extends StatelessWidget {
  static const routeName = '/check-email-screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmailValidationBloc>(
      create: (context) =>
          EmailValidationBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlocConsumer<EmailValidationBloc, EmailValidationState>(listener: (context, state) {
            if (state is ValidationEmailError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.errorMessage,
                ),
                backgroundColor: Theme.of(context).errorColor,
                action: SnackBarAction(
                  onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                  label: 'Hide',
                  textColor: Theme.of(context).accentColor,
                ),
              ));
            } else if (state is ValidationEmailSuccess) {
              BlocProvider.of<AuthBloc>(context).add(SignInAuth());
            } else if (state is ValidationEmailSent) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Validation message sent, check your email !',
                ),
                backgroundColor: Colors.black,
                action: SnackBarAction(
                  onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                  label: 'Hide',
                  textColor: Theme.of(context).accentColor,
                ),
              ));
            }
          }, builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Check your email to validate the account please.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is! ValidationEmailLoading)
                    CustomButton(
                      text: 'I\'ve verified my email',
                      onTap: () => BlocProvider.of<EmailValidationBloc>(context)
                          .add(EmailValidationChecked()),
                    )
                  else
                    loadingIndicator(context),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () =>
                        BlocProvider.of<EmailValidationBloc>(context).add(EmailValidationSent()),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Didn\'t receive validation email ? ',
                            style: Theme.of(context).textTheme.bodyText1),
                        TextSpan(
                            text: 'Send again.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.bold))
                      ]),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget loadingIndicator(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 50,
      height: 40,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
