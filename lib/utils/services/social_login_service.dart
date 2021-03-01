import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/utils/services/app_url.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

class SocialLoginService {
  SessionManager session = new SessionManager();
  Future<UserData> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null) {
        final user = new UserData();
        final Map<String, dynamic> data = {
          'provider': 'google',
          'access_token': googleAuth.accessToken
        };
        var dio = new Dio();
        Map loginData = new Map();
        try {
          Response response = await dio.post(AppUrl.socialLogin,
              data: data,
              options: new Options(contentType: Headers.jsonContentType));

          if (response.statusCode == 200) {
            loginData = response.data;
          } else {
            print("Error : " + response.data.toString());
          }
        } catch (e) {
          print("Error : " + e.toString());
        }
        user.access_token = loginData['access_token'];
        user.email = loginData['email'];
        user.expires = loginData['.expires'];
        user.expires_in = loginData['expires_in'];
        user.first_name = loginData['first_name'];
        user.identifier = loginData['identifier'];
        user.issued = loginData['.issued'];
        user.language = loginData['language'];
        user.last_name = loginData['last_name'];
        user.name = loginData['name'];
        // user.phone_number = loginData['phone_number'];
        user.refresh_token = loginData['refresh_token'];
        user.token_type = loginData['token_type'];
        // user.username = loginData['username'];
        user.photo_url = googleUser.photoUrl;
        session.setLogin(user);
        return user;
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<UserData> signInWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    if (result.accessToken != null) {
      var dio = new Dio();
      final graphResponse = await dio.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.height(200),email&access_token=${result.accessToken.token}');
      final profile = json.decode(graphResponse.data);

      final Map<String, dynamic> data = {
        'provider': 'Facebook',
        'access_token': result.accessToken.token
      };
      Map loginData = new Map();
      try {
        Response response = await dio.post(AppUrl.socialLogin,
            data: data,
            options: new Options(contentType: Headers.jsonContentType));

        if (response.statusCode == 200) {
          loginData = response.data;
        } else {
          print("Error : " + response.data.toString());
        }
      } catch (e) {
        print("Error : " + e.toString());
      }

      final user = new UserData();

      user.access_token = loginData['access_token'];
      user.email = loginData['email'];
      user.expires = loginData['.expires'];
      user.expires_in = loginData['expires_in'];
      user.first_name = loginData['first_name'];
      user.identifier = loginData['identifier'];
      user.issued = loginData['.issued'];
      user.language = loginData['language'];
      user.last_name = loginData['last_name'];
      user.name = loginData['name'];
      // user.phone_number = loginData['phone_number'];
      user.refresh_token = loginData['refresh_token'];
      user.token_type = loginData['token_type'];
      // user.username = loginData['username'];
      user.photo_url = profile['picture']['data']['url'];
      session.setLogin(user);
      return user;
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    session.clear();
    final FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
  }
}
