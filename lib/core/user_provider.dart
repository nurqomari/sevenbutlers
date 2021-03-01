import 'package:flutter/foundation.dart';
import 'package:sevenbutlers/domain/user.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

class UserProvider2 with ChangeNotifier {
  User2 _user2 = new User2();

  User2 get user2 => _user2;

  void setUser(User2 user2) {
    _user2 = user2;
    notifyListeners();
  }
}
