import 'package:sevenbutlers/domain/user.dart';

class LoginData {
  bool isLogin = false;
  UserData data;
  String error;
  bool isError = false;
  bool onProgress = false;

  LoginData(this.isLogin, this.data, this.error, [this.isError]);

  LoginData.init() {
    isLogin = false;
    data = null;
    error = "";
    onProgress = false;
    isError = false;
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
