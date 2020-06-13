import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chatapp/api/auth_repository.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class EmailValidationBloc extends Bloc<EmailValidationEvent, EmailValidationState> {
  final AuthRepository authRepository;

  EmailValidationBloc({@required this.authRepository});
  @override
  EmailValidationState get initialState => InitialEmailValidationState();

  @override
  Stream<EmailValidationState> mapEventToState(
    EmailValidationEvent event,
  ) async* {
    if (event is EmailValidationChecked) {
      try {
        yield ValidationEmailLoading();
        final isEmailVerified = await authRepository.isEmailVerified();
        print('bloc $isEmailVerified');
        if (isEmailVerified) {

          yield ValidationEmailSuccess();
        } else {
          yield ValidationEmailError(errorMessage: 'Email is not verified, check it again');
          yield InitialEmailValidationState();
        }
      } catch (e) {
        yield ValidationEmailError(errorMessage: authRepository.showErrorMessage(e.toString()));
        yield InitialEmailValidationState();
      }
      /// If the user didn't receive the validation email, this event is fired to re-send it once again.
    } else if (event is EmailValidationSent) {
      try {
        await authRepository.sendEmailVerification();
        yield ValidationEmailSent();
      } catch (e) {
        yield ValidationEmailError(errorMessage: authRepository.showErrorMessage(e.toString()));
        yield InitialEmailValidationState();
      }
    }
  }
}
