import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/core/auth/login/login_repository.dart';
import 'package:sevenbutlers/ui/login/data/login_data.dart';
import 'package:sevenbutlers/ui/login/events/login_event.dart';
import 'package:sevenbutlers/ui/login/events/login_state.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  void attemptLogin(String email, String password) {
    add(AttemptLoginEvent(email, password));
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptLoginEvent) {
      final params = event;
      bool isValid = true;
      LoginError error = LoginError("", "");
      LoginData result;

      if (params.email.isEmpty) {
        error.emailError = "Email address is required!";
        isValid = false;
      }

      if (params.email.isNotEmpty && !isEmailValid(params.email)) {
        error.emailError =
            "The format email is incorrect. Please check the email address and try again";
        isValid = false;
      }

      if (params.password.isEmpty) {
        error.passwordError = "Password is required!";
        isValid = false;
      }

      if (isValid) {
        result = LoginData.init();
        result.onProgress = true;
        yield LoginState(result);

        var repository = LoginRepository();
        final response =
            await repository.attemptLogin(params.email, params.password);

        if (response.isLogin) {
          print("user data: " + response.data.toString());

          result = LoginData(true, response.data, LoginError.init());
          SessionManager session = SessionManager();
          session.setLogin(response.data);
        } else {
          result = response;
        }

        yield LoginState(result);
      } else {
        result = LoginData(false, null, error);
        yield LoginState(result);
      }
    }
  }

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
