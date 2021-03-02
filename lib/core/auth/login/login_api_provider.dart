import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sevenbutlers/ui/login/data/login_data.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/utils/services/app_url.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

class LoginApiProvider {
  Future<LoginData> login(String email, String password) async {
    var loginData = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'client_id': '64001261-259A-4BB9-A60E-2179DF74FC58'
    };
    var dio = new Dio();
    try {
      Response response = await dio.post(AppUrl.login,
          data: loginData,
          options: new Options(contentType: Headers.formUrlEncodedContentType));

      if (response.statusCode == 200) {
        UserData userData = UserData.parse(response.data);
        return LoginData(true, userData, null);
      } else {
        var json = jsonDecode(response.data);
        String error = json['error_description'];
        String emailError = "";
        String passwordError = "";

        if (error.contains("password"))
          passwordError = error;
        else
          emailError = error;

        return LoginData(false, null, error, true);
      }
    } catch (e) {
      print("Error : " + e.toString());
      return LoginData(false, null, e.toString(), true);
    }
  }

  Future<String> refreshToken() async {
    var session = SessionManager();
    UserData user = await session.getUser();
    var params = {
      'grant_type': 'refresh_token',
      'refresh_token': user.refresh_token,
      'client_id': '64001261-259A-4BB9-A60E-2179DF74FC58'
    };
    var dio = new Dio();
    try {
      Response response = await dio.post(AppUrl.login,
          data: params,
          options: new Options(contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode == 200) {
        print("response 200: " + response.data.toString());
        var userData = UserData.parse(response.data);
        session.setLogin(userData);
        return "Success";
      } else {
        print("respose error refresh token" + response.data.toString());
        return "Failed refresh token";
      }
    } catch (e) {
      print(e.toString());
      return "Failed refresh token";
    }
  }
}
