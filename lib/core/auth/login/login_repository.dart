import 'package:sevenbutlers/core/auth/login/login_api_provider.dart';
import 'package:sevenbutlers/ui/login/data/login_data.dart';

class LoginRepository {
  final loginProvider = LoginApiProvider();

  Future<LoginData> attemptLogin(String email, String password) =>
      loginProvider.login(email, password);
  Future<String> refreshToken() => loginProvider.refreshToken();
}
