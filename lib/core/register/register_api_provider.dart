import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sevenbutlers/ui/register/data/register_data.dart';
import 'package:sevenbutlers/utils/services/app_url.dart';

class RegisterApiProvider {
  Future<RegistrationData> register(
      String firstname, String lastname, String email, String password) async {
    final Map<String, dynamic> data = {
      'first_name': firstname,
      'surname': lastname,
      'email': email,
      'password': password,
      'merchantcode': ''
    };

    var dio = new Dio();
    try {
      Response response = await dio.post(AppUrl.register,
          data: data,
          options: new Options(contentType: Headers.jsonContentType));

      if (response.data["status"] == "Success") {
        return RegistrationData(true, response.data.toString(), false);
      } else {
        Map json = response.data;
        String error = json['message'].toString();
        return RegistrationData(false, error, true);
      }
    } catch (e) {
      return RegistrationData(false, e.toString(), true);
    }
  }
}
