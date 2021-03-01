import 'package:sevenbutlers/domain/user.dart';

class LoginData {
  bool isLogin = false;
  UserData data;
  LoginError error;
  bool onProgress = false;

  LoginData(this.isLogin, this.data, this.error);

  LoginData.init() {
    isLogin = false;
    data = null;
    error = LoginError.init();
    onProgress = false;
  }
}

class LoginError {
  String emailError;
  String passwordError;
  String otherError;

  LoginError.init() {
    emailError = "";
    passwordError = "";
    otherError = "";
  }

  LoginError(this.emailError, this.passwordError, [this.otherError]);
}
