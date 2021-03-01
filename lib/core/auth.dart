import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as conn;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/utils/services/app_url.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'client_id': '64001261-259A-4BB9-A60E-2179DF74FC58'
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    // Response response = await post(AppUrl.login,
    //     body: json.encode(loginData),
    //     headers: {
    //       'Accept': 'application/json',
    //       'Content-Type': 'application/x-www-form-urlencoded'
    //     },
    //     encoding: Encoding.getByName("utf-8"));
    var dio = new conn.Dio();
    conn.Response response = await dio.post(AppUrl.login,
        data: loginData,
        options: new conn.Options(
            contentType: conn.Headers.formUrlEncodedContentType));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
          json.decode(response.toString());

      var userData = responseData;

      User2 authUser = User2.fromJson(userData);

      UserPreferences().saveUser2(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.toString())['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String firstname, String lastname, String email, String password) async {
    final Map<String, dynamic> registrationData = {
      'first_name': firstname,
      'surname': lastname,
      'email': email,
      'password': password,
      'merchantcode': ''
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    return await post(AppUrl.register,
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      if (responseData['status'] == 'Failed') {
        _loggedInStatus = Status.NotLoggedIn;
        print(_loggedInStatus);
        notifyListeners();

        result = {
          'status': false,
          'message': responseData['message'],
          'data': responseData
        };
      } else if (responseData['status'] == 'Success') {
        var userData = responseData['data'];
        User authUser = User.fromJson(userData);

        UserPreferences().saveUser(authUser);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
        result = {
          'status': true,
          'message': 'Successfully registered',
          'data': authUser
        };
      }
    } else {
//      if (response.statusCode == 401) Get.toNamed("/login");
      _loggedInStatus = Status.NotLoggedIn;
      print(_loggedInStatus);
      notifyListeners();
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  onError(error) {
    _loggedInStatus = Status.NotLoggedIn;
    print(_loggedInStatus);
    notifyListeners();
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
