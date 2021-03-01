import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AttemptRegisterEvent extends RegistrationEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  AttemptRegisterEvent(
      this.firstname, this.lastname, this.email, this.password);
}
