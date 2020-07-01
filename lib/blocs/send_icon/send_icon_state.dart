import 'package:equatable/equatable.dart';

abstract class SendIconState extends Equatable {
  const SendIconState();
}

class InitialSendIconState extends SendIconState {
  @override
  List<Object> get props => [];
}

class IconColored extends SendIconState{
  @override
  List<Object> get props => [];
}
