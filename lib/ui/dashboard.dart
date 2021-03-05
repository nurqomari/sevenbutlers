import 'package:flutter/material.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';
import 'package:sevenbutlers/utils/services/social_login_service.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var user = new UserData();

  @override
  void initState() {
    super.initState();
    setUser();
  }

  void clearLogin() {
    SessionManager session = SessionManager();
    SocialLoginService loginService = new SocialLoginService();
    loginService.signOut();
    session.clear();
  }

  void setUser() async {
    SessionManager session = SessionManager();
    user = await session.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to SevenButlers"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          // Center(child: Text(user.email)),
          SizedBox(height: 50),
          Center(child: Text(user.name ?? '')),
          SizedBox(height: 100),
          RaisedButton(
            onPressed: () {
              clearLogin();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login1", (route) => false);
            },
            child: Text("Logout"),
            color: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}
