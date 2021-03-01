

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {

  @override
  List<Object> get props => [];
}


class AttemptLoginEvent extends LoginEvent {

  final String email;
  final String password;

  AttemptLoginEvent(this.email, this.password);

}

class AttemptResetPasswordEvent extends LoginEvent{

  final String email;
  AttemptResetPasswordEvent(this.email);

}

class AttemptChangePasswordEvent extends LoginEvent{

  final String oldPassword,newPassword,validatePassword;
  AttemptChangePasswordEvent(this.oldPassword,this.newPassword,this.validatePassword);

}

