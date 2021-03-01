import 'package:flutter/material.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/core/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

class Welcome extends StatelessWidget {
  final User2 user2;

  Welcome({Key key, @required this.user2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserProvider2>(context).setUser(user2);
    // var user = await UserPreferences().getUser2();

    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Center(
            child: Text("WELCOME PAGE"),
          ),
          SizedBox(height: 40),
          Image(image: NetworkImage("")),
          SizedBox(height: 20),
          Row(
            children: [
              Text('Name : '),
              Text(user2.name),
            ],
          ),
          Row(
            children: [
              Text('Email : '),
              Text(user2.email),
            ],
          ),
          Row(
            children: [
              Text('Phone : '),
              Text('user2.phone_number'),
            ],
          ),
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Logout'))
        ],
      )),
    );
  }
}
