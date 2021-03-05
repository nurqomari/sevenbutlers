import 'package:equatable/equatable.dart';

abstract class ResendVerificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AttemptResendVerificationEvent extends ResendVerificationEvent {
  final String email;

  AttemptResendVerificationEvent(this.email);
}
