import 'package:sevenbutlers/ui/login/data/login_data.dart';

class LoginState {
  final LoginData data;

  LoginState(this.data);

  factory LoginState.initial() =>
      LoginState(LoginData(false, null, LoginError("", "")));
}
