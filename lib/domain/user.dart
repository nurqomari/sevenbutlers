class User {
  int userId;
  String firstname;
  String lastname;
  String email;
  String phone;
  String type;
  String token;
  String renewalToken;

  User(
      {this.userId,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.type,
      this.token,
      this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        firstname: responseData['firtname'],
        lastname: responseData['surname'],
        email: responseData['identifier'],
        phone: responseData['phone'],
        type: responseData['type'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']);
  }
}

class User2 {
  String access_token;
  String token_type;
  int expires_in;
  String refresh_token;
  String name;
  String first_name;
  String last_name;
  String username;
  String email;
  String phone_number;
  String photo_url;
  String identifier;
  String language;
  String issued;
  String expires;

  User2(
      {this.access_token,
      this.token_type,
      this.expires_in,
      this.refresh_token,
      this.name,
      this.first_name,
      this.last_name,
      this.username,
      this.email,
      this.phone_number,
      this.photo_url,
      this.identifier,
      this.language,
      this.issued,
      this.expires});

  factory User2.fromJson(Map<String, dynamic> responseData) {
    return User2(
        access_token: responseData['access_token'],
        token_type: responseData['token_type'],
        expires_in: responseData['expires_in'],
        refresh_token: responseData['refresh_token'],
        name: responseData['name'],
        first_name: responseData['first_name'],
        last_name: responseData['last_name'],
        username: responseData['username'],
        email: responseData['email'],
        phone_number: responseData['phone_number'],
        photo_url: responseData['photo_url'],
        identifier: responseData['identifier'],
        language: responseData['language'],
        issued: responseData['.issued'],
        expires: responseData['.expires']);
  }
}

class UserData {
  String access_token;
  String token_type;
  int expires_in;
  String refresh_token;
  String name;
  String first_name;
  String last_name;
  String username;
  String email;
  String phone_number;
  String photo_url;
  String identifier;
  String language;
  String issued;
  String expires;

  UserData(
      [this.access_token,
      this.token_type,
      this.expires_in,
      this.refresh_token,
      this.name,
      this.first_name,
      this.last_name,
      this.username,
      this.email,
      this.phone_number,
      this.photo_url,
      this.identifier,
      this.language,
      this.issued,
      this.expires]);

  UserData.parse(responseData) {
    try {
      access_token = responseData['access_token'];
      token_type = responseData['token_type'];
      expires_in = responseData['expires_in'];
      refresh_token = responseData['refresh_token'];
      name = responseData['name'];
      first_name = responseData['first_name'];
      last_name = responseData['last_name'];
      username = responseData['username'];
      email = responseData['email'];
      phone_number = responseData['phone_number'];
      photo_url = responseData['photo_url'];
      identifier = responseData['identifier'];
      language = responseData['language'];
      issued = responseData['.issued'];
      expires = responseData['.expires'];
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }
}
