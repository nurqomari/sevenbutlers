import 'package:sevenbutlers/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SessionManager {
  static const String KEY_ACCESS_TOKEN = "access_token";
  static const String KEY_TOKEN_TYPE = "token_type";
  static const String KEY_EXPIRES_IN = "expires_in";
  static const String KEY_REFRESH_TOKEN = "refresh_token";
  static const String KEY_NAME = "name";
  static const String KEY_FIRST_NAME = "first_name";
  static const String KEY_LAST_NAME = "last_name";
  static const String KEY_USER_NAME = "username";
  static const String KEY_EMAIL = "email";
  static const String KEY_PHONE_NUMBER = "phone_number";
  static const String KEY_PHOTO_URL = "photo_url";
  static const String KEY_IDENTIFIER = "identifier";
  static const String KEY_LANGUAGE = "language";
  static const String KEY_ISSUED = ".issued";
  static const String KEY_EXPIRES = ".expires";

  static const String KEY_IS_LOGGED_IN = "is_logged_in";

  static const String KEY_IS_FIRST_TIME = "is_first_time";

  static const String KEY_REGISRATION_FIRST_NAME = "firstname";
  static const String KEY_REGISRATION_LAST_NAME = "lastname";
  static const String KEY_REGISRATION_EMAIL = "email";

  void setLogin(UserData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_ACCESS_TOKEN, data.access_token);
    await prefs.setString(KEY_TOKEN_TYPE, data.token_type);
    await prefs.setInt(KEY_EXPIRES_IN, data.expires_in);
    await prefs.setString(KEY_REFRESH_TOKEN, data.refresh_token);
    await prefs.setString(KEY_NAME, data.name);
    await prefs.setString(KEY_FIRST_NAME, data.first_name);
    await prefs.setString(KEY_LAST_NAME, data.last_name);
    await prefs.setString(KEY_USER_NAME, data.username);
    await prefs.setString(KEY_EMAIL, data.email);
    await prefs.setString(KEY_PHONE_NUMBER, data.phone_number);
    await prefs.setString(KEY_PHOTO_URL, data.photo_url);
    await prefs.setString(KEY_IDENTIFIER, data.identifier);
    await prefs.setString(KEY_LANGUAGE, data.language);
    await prefs.setString(KEY_ISSUED, data.issued);
    await prefs.setString(KEY_EXPIRES, data.expires);
    await prefs.setBool(KEY_IS_LOGGED_IN, true);
  }

  Future<UserData> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserData data = UserData(
          prefs.getString(KEY_ACCESS_TOKEN),
          prefs.getString(KEY_TOKEN_TYPE),
          prefs.getInt(KEY_EXPIRES_IN),
          prefs.getString(KEY_REFRESH_TOKEN),
          prefs.getString(KEY_NAME),
          prefs.getString(KEY_FIRST_NAME),
          prefs.getString(KEY_LAST_NAME),
          prefs.getString(KEY_USER_NAME),
          prefs.getString(KEY_EMAIL),
          prefs.getString(KEY_PHONE_NUMBER),
          prefs.getString(KEY_PHOTO_URL),
          prefs.getString(KEY_IDENTIFIER),
          prefs.getString(KEY_LANGUAGE),
          prefs.getString(KEY_ISSUED),
          prefs.getString(KEY_EXPIRES));
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_IS_LOGGED_IN);
  }

  Future<bool> setFirstTime(bool first) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KEY_IS_FIRST_TIME, first);
    return true;
  }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(KEY_IS_FIRST_TIME) == null) {
      await prefs.setBool(KEY_IS_FIRST_TIME, false);
    }
    return prefs.getBool(KEY_IS_FIRST_TIME);
  }

  void setRegistrationData(
      String firstname, String lastname, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_REGISRATION_FIRST_NAME, firstname);
    await prefs.setString(KEY_REGISRATION_LAST_NAME, lastname);
    await prefs.setString(KEY_REGISRATION_EMAIL, email);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    prefs.remove("token_type");
    prefs.remove("expires_in");
    prefs.remove("refresh_token");
    prefs.remove("name");
    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.remove("username");
    prefs.remove("email");
    prefs.remove("phone_number");
    prefs.remove("photo_url");
    prefs.remove("identifier");
    prefs.remove("language");
    prefs.remove("issued");
    prefs.remove("expires");
    print("clear user preferences");
    return true;
  }
}

// OLD code
class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId);
    prefs.setString("firstname", user.firstname);
    prefs.setString("lastname", user.lastname);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("type", user.type);
    prefs.setString("token", user.token);
    prefs.setString("renewalToken", user.renewalToken);

    print(user.email);

    return prefs.commit();
  }

  Future<bool> saveUser2(User2 user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("access_token", user.access_token);
    prefs.setString("token_type", user.token_type);
    prefs.setInt("expires_in", user.expires_in);
    prefs.setString("refresh_token", user.refresh_token);
    prefs.setString("name", user.name);
    prefs.setString("first_name", user.first_name);
    prefs.setString("last_name", user.last_name);
    prefs.setString("username", user.username);
    prefs.setString("email", user.email);
    prefs.setString("phone_number", user.phone_number);
    prefs.setString("photo_url", user.photo_url);
    prefs.setString("identifier", user.identifier);
    prefs.setString("language", user.language);
    prefs.setString("issued", user.issued);
    prefs.setString("expires", user.expires);

    print(user);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    String firstname = prefs.getString("firstname");
    String lastname = prefs.getString("lastname");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String type = prefs.getString("type");
    String token = prefs.getString("token");
    String renewalToken = prefs.getString("renewalToken");

    return User(
        userId: userId,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        type: type,
        token: token,
        renewalToken: renewalToken);
  }

  Future<User2> getUser2() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String access_token = prefs.getString("access_token");
    String token_type = prefs.getString("token_type");
    int expires_in = prefs.getInt("expires_in");
    String refresh_token = prefs.getString("refresh_token");
    String name = prefs.getString("name");
    String first_name = prefs.getString("first_name");
    String last_name = prefs.getString("last_name");
    String username = prefs.getString("username");
    String email = prefs.getString("email");
    String phone_number = prefs.getString("phone_number");
    String photo_url = prefs.getString("photo_url");
    String identifier = prefs.getString("identifier");
    String language = prefs.getString("language");
    String issued = prefs.getString("issued");
    String expires = prefs.getString("expires");

    return User2(
        access_token: access_token,
        token_type: token_type,
        expires_in: expires_in,
        refresh_token: refresh_token,
        name: name,
        first_name: first_name,
        last_name: last_name,
        username: username,
        email: email,
        phone_number: phone_number,
        photo_url: photo_url,
        identifier: identifier,
        language: language,
        issued: issued,
        expires: expires);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("access_token");
    prefs.remove("token_type");
    prefs.remove("expires_in");
    prefs.remove("refresh_token");
    prefs.remove("name");
    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.remove("username");
    prefs.remove("email");
    prefs.remove("phone_number");
    prefs.remove("photo_url");
    prefs.remove("identifier");
    prefs.remove("language");
    prefs.remove("issued");
    prefs.remove("expires");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
